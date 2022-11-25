#' Umap of the protein expression levels
#'
#' `umap_of_protein_expressions()` takes a prepared data frame, `.data`, and
#'     reduces the expression levels of all 13 proteins to 2 dimensions,
#'     to show general tendencies.
#'
#'
#' @inheritParams summarise_with_filter
#'
#' @param max_frequency A float representing the maximum allowed value of frequencies.
#'
#' @param color_by A variable name to choose which protein expression level to
#'     color by.
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
#' # The protein to color by can be changed:
#' data_combined_tidy %>%
#'     umap_of_protein_expressions(color_by = "CD3")
#'

umap_of_protein_expressions <- function(.data,
                                        color_by = "CD45RA") {

  data_combined_tidy_temp <- .data %>%
    dplyr::filter(donor == "donor4") %>%
    dplyr::distinct(barcode, .keep_all = TRUE) %>%
    dplyr::select(dplyr::matches("CD|Ig|HLA")) %>%
    dplyr::slice_sample(prop = 1)


  umap_model <- data_combined_tidy_temp %>%
                  dplyr::select(dplyr::matches("CD|Ig|HLA-DR")) %>%
                  uwot::umap(n_neighbors = 15,
                             min_dist = 0.2,
                             metric = "euclidean")

  umap_plot <- dplyr::bind_cols(umap_model %>% tibble::as_tibble(.name_repair = "unique"),
                                data_combined_tidy_temp) %>%
    ggplot2::ggplot(ggplot2::aes_string(x = "V1",
                                 y = "V2",
                                 color = color_by)) +
    ggplot2::geom_point() +
    ggplot2::scale_color_continuous(type = "viridis")

  return(umap_plot)
}
