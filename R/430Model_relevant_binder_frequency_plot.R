#' Title
#'
#' @inheritParams summarise_with_filter
#'
#' @return An interactive plotly plot with different relevant alpha:beta pairs,
#'     and pMHC. The size of dots depends on the frequency of that specific
#'     interaction occuring compared to other pMHC which bind the same
#'     alpha:beta pair.
#'
#' @family Modelling functions
#' @export
relevant_binder_frequency_plot <- function(.data,
                                           identifier = barcode,
                                           max_frequency = 1) {

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
    dplyr::filter(n_frequency < max_frequency)


  frequency_plot <-
    frequency_data %>%
    plotly::plot_ly(
      x = ~non_promiscuous_pair,
      y = ~pMHC,
      type = "scatter",
      mode = "markers",
      marker = list(
        size = ~n_frequency*15
      )
    ) %>%
    plotly::layout(
      title = "Frequencies of binding between pMHC and alpha:beta pairs",
      xaxis = list(showticklabels = FALSE),
      yaxis = list(showticklabels = FALSE)
    )
return(frequency_plot)
}
