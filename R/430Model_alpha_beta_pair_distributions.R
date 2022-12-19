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
#' @return Returns a bar plot with a frequency distribution of the different
#'     combinations of alpha- beta pairs.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # The function is run by simply piping `.data` into it:
#' data_combined_tidy %>%
#'     alpha_beta_pair_distribution()
#'
#'

alpha_beta_pair_distribution <- function(.data,
                                         identifier = barcode) {

  frequency_barplot <-
    .data %>%
    dplyr::distinct(donor,
                    {{identifier}},
                    .keep_all = TRUE) %>%
    ggplot2::ggplot(mapping = ggplot2::aes(x = TCR_combination,
                                           y = ggplot2::after_stat(prop),
                                           group = 1,
                                           fill = factor(ggplot2::after_stat(x))
                                           )) +
        ggplot2::geom_bar() +
        ggplot2::scale_x_discrete(labels = c("one_alpha_only" = "alpha:",
                                             "one_beta_only" = ":beta",
                                             "one_alpha_one_beta" = "alpha:beta",
                                             "other" = "Other")) +
        ggplot2::labs(x = "TCR-combinations",
                      y = "Frequencies",
                      title = "Frequency distribution of different combinations of TCR") +
        ggplot2::theme(legend.position = "none") +
        ggplot2::facet_wrap(~  donor)

  return(frequency_barplot)
}
