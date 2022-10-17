#' Title
#'
#' @inheritParams summarise_with_filter
#'
#' @param pMHC_filter A pMHC to use for filtering, to only include that specific
#'     pMHC from the data set. Default is `FALSE`, i.e. no filtering.
#'
#' @return Returns a bar plot with a frequency distribution of the different
#'     combinations of alpha- beta pairs.
#'
#' @family Modelling functions
#' @export
alpha_beta_pair_distribution <- function(.data,
                                         pMHC_filter = NULL) {

  if (!is.null(pMHC_filter)) {
    .data <-
      .data %>%
      dplyr::filter(pMHC == pMHC_filter)
    }

  frequency_barplot <-
    .data %>%
    ggplot2::ggplot(mapping = ggplot2::aes(x = TCR_combination,
                                           y = ..prop..,
                                           group = 1,
                                           fill = factor(..x..)
                                           )) +
        ggplot2::geom_bar() +
        ggplot2::scale_x_discrete(labels = c("one_alpha_only" = "alpha:",
                                             "one_beta_only" = ":beta",
                                             "one_alpha_one_beta" = "alpha:beta",
                                             "other" = "Other")) +
        ggplot2::labs(x = "TCR-combinations",
                      y = "Frequencies",
                      title = "Frequency distribution of different combinations of TCR") +
        ggplot2::theme(legend.position="none")

  return(frequency_barplot)
}
