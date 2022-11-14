#' Interactive plot showing relevant binders between pMHC and TCR-sequences
#'
#' `relevant_binder_frequency_plot()` takes a prepared data frame, `.data`, and
#'     count the number of relevant binders stratified on both non-promiscuous
#'     pairs and pMHC. The frequency of a specific pMHC is calculated based on
#'     the total number of pMHCs which bind to a non-promiscuous pair. The output
#'     is a plotly plot, meaning it is interactive. The x- and y-values can be
#'     found by hovering a dot in the plot.
#'
#' @inheritParams summarise_with_filter
#'
#' @param max_frequency A float representing the maximum allowed value of frequencies.
#'
#' @return An interactive plotly plot with different relevant non-promiscuous pairs
#'     and pMHC. The size of dots depends on the frequency of that specific
#'     interaction occuring compared to other pMHC which bind the same
#'     non-promiscuous pair.
#'
#' @family Modelling functions
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_donor_four_tidy %>%
#'     relevant_binder_frequency_plot()
#'
#' # The maximum value of allowed frequencies can be changed:
#' data_donor_four_tidy %>%
#'     relevant_binder_frequency_plot(max_frequency = 0.8)
#'

old_relevant_binder_frequency_plot <- function(.data,
                                           identifier = barcode,
                                           max_frequency = 1.0) {

  frequency_plot_ggplot <- .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    tidyr::drop_na(non_promiscuous_pair) %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::group_by(non_promiscuous_pair, pMHC) %>%
    dplyr::count() %>%
    dplyr::group_by(non_promiscuous_pair) %>%
    dplyr::mutate(frequency = n/sum(n)) %>%
    dplyr::filter(frequency <= max_frequency) %>%

    ggplot2::ggplot(ggplot2::aes(x = non_promiscuous_pair,
                                 y = pMHC,
                                 text = paste('TCR: ', non_promiscuous_pair,
                                              '<br>pMHC:', pMHC,
                                              '<br>Frequency:', round(frequency,
                                                                      digits = 2)))) +
      ggplot2::geom_point(ggplot2::aes(size = frequency),
                          color = "steelblue") +
      ggplot2::scale_size_continuous(range = c(1, 3)) +
      ggplot2::scale_x_discrete("Non-promiscuous TCR-Sequences",
                              expand=c(0.015, 0)) +
      ggplot2::ggtitle("Frequencies of binding between pMHC and alpha:beta pairs") +
      ggplot2::theme(
        axis.ticks = ggplot2::element_blank(),
        axis.text = ggplot2::element_blank(),
        panel.grid.major.x = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank()
    )

  frequency_plot_plotly <- plotly::ggplotly(frequency_plot_ggplot,
                                            tooltip = "text")

return(frequency_plot_plotly)
}
