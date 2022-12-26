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
                                        identifier = barcode,
                                        plot_protein = "CD4") {
  plot_protein <- plot_protein %>%
    make.names()

  data_temp <- dplyr::bind_cols(.data %>%
                                  dplyr::select(dplyr::matches("CD|HLA-DR")) %>%
                                  compositions::clr() %>%
                                  tibble::as_tibble(),
                                .data %>%
                                  dplyr::select(donor, {{identifier}}))
  colnames(data_temp) <- data_temp %>%
    colnames() %>%
    make.names()

  boxplot <- data_temp %>%
    dplyr::distinct(donor,
                    {{identifier}},
                    .keep_all = TRUE) %>%

    ggplot2::ggplot(ggplot2::aes(x = donor,
                                 y = eval(parse(text = plot_protein)),
                                 fill = donor)) +
      ggplot2::geom_boxplot(outlier.shape = NA) +
      ggplot2::geom_point(size = 1.5,
                          pch = 21,
                          color = "black",
                          position = ggplot2::position_jitterdodge(jitter.width = 0.05)) +
      ggplot2::labs(x = "Donor",
                    caption = "clr transformed",
                    y = stringr::str_c("Expression of ", plot_protein),
                    title = stringr::str_c("Protein expression of ", plot_protein, " stratified on donor")) +
      ggplot2::theme(legend.position = "none")

  return(boxplot)

}
