#' Title
#'
#' @inheritParams summarise_binders
#'
#' @param TCR_sequence_input A string which matches a TCR-sequence in the input
#'     data frame. Is then used for filtering, to only look at the frequencies
#'     of different alleles for this particular TCR-sequence.
#'     Default is arbitrarily set to `"CAARVRGFGNVLHC"`.
#'
#' @return A bar plot with the frequencies of all alleles for a particular
#'     TCR-sequence.
#'
significant_binder_frequency_plot <- function(.data) {

  frequency_data <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    tidyr::drop_na(non_promiscuous_pair) %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%
    dplyr::group_by(non_promiscuous_pair, pMHC) %>%
    dplyr::count() %>%
    dplyr::group_by(non_promiscuous_pair) %>%
    dplyr::mutate(n_frequency = n/sum(n)) %>%
    dplyr::filter(n_frequency < 1)


  frequency_plot <-
    frequency_data %>%
    plotly::plot_ly(
      x = ~non_promiscuous_pair,
      y = ~pMHC,
      type = "scatter",
      mode = "markers",
      size = ~n_frequency
    ) %>%
    plotly::layout(
      title = "Frequencies of binding between pMHC and alpha:beta pairs",
      xaxis = list(showticklabels = FALSE),
      yaxis = list(showticklabels = FALSE)
    )
return(frequency_plot)
}



'ggplot2::ggplot(mapping = ggplot2::aes(x = pMHC,
                                                    y = ..prop..,
                                                    group = 1)) +
      ggplot2::geom_bar() +
      ggplot2::coord_flip() +
      ggplot2::labs(title = "Frequencies of alleles for a specific TCR-sequence",
                    x = "Allele",
                    y = "Frequency")'
