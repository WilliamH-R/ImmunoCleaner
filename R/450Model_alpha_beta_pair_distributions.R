#' Bar plot showing distribution of TCR-sequence promiscuity
#'
#' `alpha_beta_pair_distribution()` takes as input a prepared data frame. It plots
#'     the distribution of categories found in the column `TCR_combination`.
#'     A total of four categories exist:
#'     * Only one alpha chain and no beta chain
#'     * No alpha chain and one beta chain
#'     * One alpha- and one beta chain
#'     * Other combinations
#'
#' @inheritParams summarise_with_filter
#'
#' @param pMHC_filter A pMHC to use for filtering, to only include that specific
#'     pMHC from the data set. Default is `NULL`, i.e. no filtering. Must be
#'     supplied as string.
#'
#' @return Returns a bar plot with a frequency distribution of the different
#'     combinations of alpha- beta pairs.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # The function is run by simply piping `.data` into it:
#' data_donor_one_tidy %>%
#'     alpha_beta_pair_distribution()
#'
#' # A specific pMHC can be specified to show distribution of only that pMHC:
#' data_donor_one_tidy %>%
#'     alpha_beta_pair_distribution(pMHC_filter = "A0101_VTEHDTLLY_IE-1_CMV")
#'

alpha_beta_pair_distribution <- function(.data,
                                         identifier = barcode,
                                         pMHC_filter = NULL) {

  if (!is.null(pMHC_filter)) {
    .data <-
      .data %>%
      dplyr::filter(pMHC == pMHC_filter)
  }

  frequency_barplot <-
    .data %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    ggplot2::ggplot(mapping = ggplot2::aes(x = TCR_combination,
                                           y = ggplot2::after_stat(prop),
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
        ggplot2::theme(legend.position="none") +
        ggplot2::facet_wrap(~  donor)

  return(frequency_barplot)
}
