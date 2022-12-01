#' Umap of the protein expression levels
#'
#' `boxplot_protein_expressions()` takes a prepared data frame, `.data`, and
#'     pivots the data longer, to allow for a boxplot to show protein
#'     expression levels.
#'
#' @inheritParams summarise_with_filter
#'
#' @return Boxplots for each donor and protein present in the data set
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_combined_tidy %>%
#'     boxplot_protein_expressions()
#'

boxplot_protein_expressions <- function(.data) {

  boxplot <- .data %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%
    dplyr::select(dplyr::matches("donor|CD|Ig|HLA-DR")) %>%
    tidyr::pivot_longer(names_to = "protein_name",
                        values_to = "expression_level",
                        cols = -donor) %>%

    ggplot2::ggplot(ggplot2::aes(x = protein_name,
                                 y = log10(expression_level))) +
      ggplot2::geom_boxplot() +
      ggplot2::facet_wrap(donor ~ protein_name,
                          scales = "free")

  return(boxplot)

}
