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
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_donor_four %>%
#'     relevant_binder_frequency_plot()
#'
#' # The maximum value of allowed frequencies can be changed:
#' data_donor_four %>%
#'     relevant_binder_frequency_plot(max_frequency = 0.8)
#'

relevant_binder_frequency_plot <- function(.data,
                                           identifier = barcode,
                                           max_frequency = 1.0) {

  frequency_data <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    tidyr::drop_na(non_promiscuous_pair) %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::group_by(non_promiscuous_pair, pMHC) %>%
    dplyr::count() %>%
    dplyr::group_by(non_promiscuous_pair) %>%
    dplyr::mutate(n_frequency = n/sum(n)) %>%
    dplyr::filter(n_frequency <= max_frequency)


  frequency_plot <-
    frequency_data %>%
    plotly::plot_ly(
      x = ~non_promiscuous_pair,
      y = ~pMHC,
      type = "scatter",
      mode = "markers",
      marker = list(
        size = ~n_frequency*15
      ),
      height = 750
    ) %>%
    plotly::layout(
      title = list(text = "Frequencies of binding between pMHC and alpha:beta pairs",
                   x = 0),
      xaxis = list(title = "Non-promiscuous TCR-Sequences",
                   showticklabels = FALSE),
      yaxis = list(showticklabels = FALSE)
    )
return(frequency_plot)
}
