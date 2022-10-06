#' Title
#'
#' @inheritParams summarise_with_filter
#'
#' @return Returns a bar plot with the relative distinctiveness of all alpha
#'     and beta chains. Meaning a lower value, means less distinctive sequences
#'     compared to the total number of that chain.
#'
#' @family Modelling functions
#' @export
alpha_beta_consistency <- function(.data,
                                   identifier = barcode) {

  chain_count <-
    .data %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::distinct(TCR_sequence,
                    .keep_all = TRUE) %>%
    dplyr::ungroup() %>%
    dplyr::count(chain)


  .data %>%
    dplyr::distinct(TCR_sequence,
                    .keep_all = TRUE) %>%
    dplyr::count(chain) %>%
    dplyr::mutate(n = dplyr::case_when(chain == "alpha" ~ n/chain_count$n[1],
                                       chain == "beta" ~ n/chain_count$n[2])) %>%

    ggplot2::ggplot(mapping = ggplot2::aes(x = chain,
                                           y = n,
                                           fill = chain)) +
      ggplot2::geom_bar(stat = "identity") +
      ggplot2::labs(x = "Chain",
                    y = "Relative distinctiveness",
                    title = "Relative distinctiveness for the alpha and beta chain")
}
