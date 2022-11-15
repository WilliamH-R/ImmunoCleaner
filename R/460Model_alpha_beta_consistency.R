#' Bar plot showing consistency of the alpha- and beta chains
#'
#' `alpha_beta_consistency()` takes as input a prepared data frame. Firstly,
#'     the total number of alpha- and beta chains are calculated respectively.
#'     This is done by grouping on `identifier` (i.e. experiments) and making
#'     `TCR_sequence` distrinct and then counting. Secondly, the number of different
#'     alpha- and beta chains respectively is counted. This is done by making them
#'     distinct without grouping. The distinctiveness is then calculated as
#'     number of unique divided by total number of chains, statified on chain type.
#'
#' @inheritParams summarise_with_filter
#'
#' @return Returns a bar plot with the relative distinctiveness of all alpha
#'     and beta chains. A lower value means less distinctive sequences
#'     compared to the total number of that chain.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # The function takes no arguments to alter the plot:
#' data_donor_two_tidy %>%
#'     alpha_beta_consistency()
#'

alpha_beta_consistency <- function(.data,
                                   identifier = barcode) {

  data_combined_tidy %>%
    dplyr::select({{identifier}}, donor, TCR_sequence, chain) %>%
    dplyr::group_by(donor,
                    {{identifier}}) %>%
    dplyr::distinct(TCR_sequence,
                    .keep_all = TRUE) %>%
    dplyr::group_by(donor) %>%
    dplyr::add_count(chain,
                     name = "total_chains") %>%
    dplyr::distinct(TCR_sequence,
                    .keep_all = TRUE) %>%
    dplyr::add_count(chain,
                     name = "unique_chains") %>%
    dplyr::mutate(distinctiveness = unique_chains/total_chains) %>%

    ggplot2::ggplot(mapping = ggplot2::aes(x = chain,
                                           y = distinctiveness,
                                           fill = chain)) +
      ggplot2::geom_bar(stat = "identity") +
      ggplot2::labs(x = "Chain",
                    y = "Relative distinctiveness",
                    title = "Relative distinctiveness for the alpha and beta chain") +
      ggplot2::theme(legend.position="none") +
      ggplot2::facet_wrap(~donor)
}

