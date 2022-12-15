#' Umap of the protein expression levels
#'
#' `umap_of_protein_expressions()` takes a prepared data frame, `.data`, and
#'     projects the data points via the already made models included in the
#'     package.
#'
#'
#' @inheritParams summarise_with_filter
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

  umap_coords <- NULL

  for (chosen_donor in .data %>%
                         dplyr::pull(donor) %>%
                         unique()) {

    data_combined_tidy_temp <- .data %>%
      dplyr::filter(donor == chosen_donor) %>%
      dplyr::distinct(barcode,
                      .keep_all = TRUE) %>%
      dplyr::select(dplyr::matches("CD|HLA-DR|donor"))

    umap_model <- uwot::load_uwot(file = system.file(stringr::str_c("data/umap_model_",
                                                                    chosen_donor),
                                                     package = "TCRSequenceFunctions"))

    umap_embed <- data_combined_tidy_temp %>%
      dplyr::select(dplyr::matches("CD|HLA-DR")) %>%
      uwot::umap_transform(model = umap_model) %>%
      as.data.frame() %>%
      tibble::as_tibble()

    uwot::unload_uwot(umap_model)


    umap_coords <- dplyr::bind_rows(umap_coords,
                                    dplyr::bind_cols(umap_embed,
                                                     data_combined_tidy_temp))
  }

  umap_plot <- umap_coords %>%
    ggplot2::ggplot(ggplot2::aes(x = V1,
                                 y = V2,
                                 color = eval(parse(text = color_by)))) +
    ggplot2::geom_point() +
    ggplot2::scale_color_continuous(type = "viridis") +
    ggplot2::labs(color = stringr::str_c("Protein expression of",
                                         color_by,
                                         sep = " ")) +
    ggplot2::facet_wrap(~ donor)

  return(umap_plot)
}
