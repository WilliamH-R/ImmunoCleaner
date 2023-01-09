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
                                        plot_protein = "CD8a") {
  plot_protein <- plot_protein %>%
    make.names()

  .data <- dplyr::bind_cols(.data %>%
                              dplyr::select(dplyr::matches("CD|HLA-DR")) %>%
                              TCRSequenceFunctions:::clr_log2() %>%
                              tibble::as_tibble(),
                            .data %>%
                              dplyr::select(donor, {{identifier}}))

  colnames(.data) <- .data %>%
    colnames() %>%
    make.names()

  data_summary <- .data %>%
    dplyr::distinct(donor,
                    {{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::group_by(donor) %>%
    dplyr::summarise(count = dplyr::n())

  boxplot <- .data %>%
    dplyr::distinct(donor,
                    {{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::left_join(data_summary,
                     by = "donor") %>%
    dplyr::mutate(x_axis = stringr::str_c(donor, "\n", "count = ", count)) %>%

    ggplot2::ggplot(ggplot2::aes(x = x_axis,
                                 y = eval(parse(text = plot_protein)),
                                 fill = donor)) +
      ggplot2::geom_boxplot(width = 0.5) +
      ggplot2::labs(x = "Donor",
                    caption = "clr transformed, log2",
                    y = stringr::str_c("Expression of ", plot_protein),
                    title = stringr::str_c("Protein expression of ", plot_protein, " stratified on donor")) +
      ggplot2::theme(legend.position = "none") +
      ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = c(0, 0)),
                                  limits = c(-10, 10))

  return(boxplot)

}
