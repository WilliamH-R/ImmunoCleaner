#' Interactive plot showing relevant binders between pMHC and TCR-sequences
#'
#' `relevant_binder_frequency_plot()` takes a prepared data frame, `.data`, and
#'     plot pMHC vs non-promiscuous TCR-sequences. Marker size represent number
#'     of barcodes which support that specific interaction. The color is based
#'     on concordance which is fraction of barcodes that support a given pMHC
#'     stratified on non-promiscuous TCR-sequences
#'
#'
#'
#'
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
#' @export
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

relevant_binder_frequency_plot <- function(.data,
                                           identifier = barcode,
                                           max_frequency = 1.0,
                                           plotly_option = TRUE) {
  frequency_plot_ggplot <-
    .data %>%
    dplyr::select({{identifier}}, donor, non_promiscuous_pair, pMHC, is_binder) %>%
    dplyr::filter(is_binder == TRUE) %>%
    tidyr::drop_na(non_promiscuous_pair) %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::count(donor, non_promiscuous_pair, pMHC,
                     name = "barcode_count") %>%
    dplyr::group_by(donor, non_promiscuous_pair) %>%
    dplyr::mutate(barcode_freq = barcode_count/sum(barcode_count)) %>%
    dplyr::filter(barcode_freq <= max_frequency) %>%

    ggplot2::ggplot(ggplot2::aes(x = non_promiscuous_pair,
                                 y = pMHC,
                                 size = barcode_count,
                                 color = barcode_freq,
                                 text = paste('TCR: ', non_promiscuous_pair,
                                              '<br>pMHC:', pMHC,
                                              '<br>Frequency:', round(barcode_freq,
                                                                      digits = 2),
                                              '<br>Barcodes:', barcode_count))) +
    ggplot2::geom_point(alpha = 0.5) +
    ggplot2::labs(x = "Non-promiscuous TCR-sequences",
                  title = "Frequencies of binding between pMHC and TCR-sequences",
                  size = "Barcodes",
                  color = "Concordance"
                  ) +
    ggplot2::theme(
      axis.ticks = ggplot2::element_blank(),
      axis.text = ggplot2::element_blank(),
      panel.grid.major.x = ggplot2::element_blank(),
      panel.grid.minor.x = ggplot2::element_blank(),
      legend.position = "bottom"
    ) +
    ggplot2::scale_size_continuous(range = c(2, 7)) +
    ggplot2::scale_x_discrete(expand=c(0.015, 0)) +
    ggplot2::scale_colour_gradient(low = "#FFFF0095",
                                   high = "#FF000095",
                                   na.value = NA) +
    ggplot2::facet_wrap(~ donor,
                        ncol = 1,
                        scales = "free_x")

  frequency_plot_plotly <- plotly::ggplotly(frequency_plot_ggplot,
                                            tooltip = "text")
  if (plotly_option) {
    return(frequency_plot_plotly)
  } else {
    return(frequency_plot_ggplot)
  }

}

