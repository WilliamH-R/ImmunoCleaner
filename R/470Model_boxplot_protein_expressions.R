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
#' # The protein to be plotted can be changed by supplying it as a string:
#' data_combined_tidy %>%
#'     boxplot_protein_expressions(plot_protein = "CD8a")

boxplot_protein_expressions <- function(.data,
                                        plot_protein = "CD4") {

  boxplot <- .data %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%

    ggplot2::ggplot(ggplot2::aes(x = donor,
                                 y = eval(parse(text = plot_protein)),
                                 fill = donor)) +
      ggplot2::geom_boxplot() +
      ggplot2::labs(x = "Donor",
                    caption = "log10 transformed",
                    y = stringr::str_c("expression of ",
                                       plot_protein),
                    title = "Protein expression of chosen protein stratified on donor") +
      ggplot2::theme(legend.position = "none") +
      ggplot2::scale_y_log10()

  return(boxplot)

}
