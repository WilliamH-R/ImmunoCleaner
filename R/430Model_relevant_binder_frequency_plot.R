#' Scatterplot of pMHC vs. TCR-sequences
#'
#' `relevant_binder_frequency_plot()` plots all pMHC vs. those non-promiscuous
#'     TCR-sequences which has been evaluated to be relevant by `?evaluate_binder`.
#'     The size of a dot reflects how frequent a specific pMHC is to a TCR-sequence
#'     out of all the pMHC which has been evaluated as relevant binders.
#'
#' @inheritParams summarise_with_filter
#'
#' @param max_frequency Is a double used as a threshold for filtering. Only
#'    frequencies below, or equal to, this value is used.
#'
#' @return An interactive plotly plot with different relevant alpha:beta pairs
#'     (TCR-sequences), and pMHC. The size of dots depends on the frequency of
#'     that specific interaction occuring compared to other pMHC which bind the
#'     same alpha:beta pair.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame needs to be provided. Can either be done by using
#' # the already cleaned data frames or the raw data files piped through `?run_all_prep`
#' data_donor_one %>%
#'     relevant_binder_frequency_plot()
#'
#' vdj_v1_hs_aggregated_donor1_binarized_matrix %>%
#'     run_all_prep() %>%
#'     relevant_binder_frequency_plot()
#'
#' # The frequency can be limited by:
#' data_donor_one %>%
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
      )
    ) %>%
    plotly::layout(
      title = list(text = "Frequencies of binding between pMHC and alpha:beta pairs",
                   x = 0,
                   y = 1),
      xaxis = list(title = "Non promiscuous TCR-sequences",
                   showticklabels = FALSE),
      yaxis = list(showticklabels = FALSE)
    )
return(frequency_plot)
}
