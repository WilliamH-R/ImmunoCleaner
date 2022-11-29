#' Umap of the protein expression levels
#'
#' `umap_of_protein_expressions()` takes a prepared data frame, `.data`, and
#'     reduces the expression levels of all 14 proteins to 2 dimensions,
#'     to show general tendencies.
#'
#'
#' @inheritParams summarise_with_filter
#'
#' @param color_by A variable name to choose which protein expression level to
#'     color by.
#'
#' @param frac_include A float ranging `[0..1]` representing the fraction of
#'     randomly selected rows to use for modelling. Computation time can
#'     otherwise be quite high, and a low default of `0.2` is chosen.
#'
#' @return A scatter plot to show tendencies of the gene expression levels.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_combined_tidy %>%
#'     umap_of_protein_expressions()
#'
#' # The protein to color by can be changed along with fraction of inlcuded rows:
#' data_combined_tidy %>%
#'     umap_of_protein_expressions(color_by = "CD3",
#'                                 frac_include = 0.5)
#'

umap_of_protein_expressions <- function(.data,
                                        color_by = "CD45RA",
                                        frac_include = 0.2) {

  umap_model <- tibble::tibble()

  for (chosen_donor in .data %>%
                         dplyr::select(donor) %>%
                         dplyr::distinct()) {

    data_combined_tidy_temp <- .data %>%
      dplyr::filter(donor == chosen_donor[1]) %>%
      dplyr::distinct(barcode,
                      .keep_all = TRUE) %>%
      dplyr::select(dplyr::matches("CD|Ig|HLA-DR|donor")) %>%
      dplyr::slice_sample(prop = frac_include)


    umap_model <- dplyr::bind_rows(data_combined_tidy_temp %>%
                                     dplyr::select(dplyr::matches("CD|Ig|HLA-DR")) %>%
                                     uwot::umap(n_neighbors = 15,
                                                min_dist = 0.2,
                                                metric = "euclidean") %>%
                                     as.array() %>%
                                     tibble::as_tibble() %>%
                                     dplyr::bind_cols(data_combined_tidy_temp),
                                   umap_model)
  }

  umap_plot <- umap_model %>%
    ggplot2::ggplot(ggplot2::aes(x = V1,
                                 y = V2,
                                 color = eval(parse(text = color_by)))) +
    ggplot2::geom_point() +
    ggplot2::scale_color_continuous(type = "viridis") +
    ggplot2::labs(color = stringr::str_c("Expression of", color_by, sep = " ")) +
    ggplot2::facet_wrap(~ donor)

  return(umap_plot)
}
