#' Title
#'
#' @inheritParams add_max_non_specific_binder
#' @inheritParams add_chain_ident_remove_prefix
#'
#' @return The same data frame, but with an added column `TCR_combination`.
#'     It contains a categorical value for a specific combination of alpha
#'     and beta sequence:
#'     * If only an alpha sequence, then `0`
#'     * If only a beta sequence, then `1`
#'     * If one alpha- and beta sequence, then `2`
#'     * Otherwise will by noted as `3`
#'
#' @family Augmenting functions
#' @noRd
#'
add_TCR_combination_identifier <- function(.data,
                                           identifier = barcode,
                                           identifier_string = "barcode") {
  data_aug <-
    .data %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::distinct(TCR_sequence,
                    .keep_all = TRUE) %>%
    dplyr::mutate(TCR_combination = dplyr::case_when(sum(stringr::str_count(string = chain,
                                                                            pattern = "alpha")) == 1 &
                                                       sum(stringr::str_count(string = chain,
                                                                              pattern = "beta")) == 0 ~ "one_alpha_only",
                                                     sum(stringr::str_count(string = chain,
                                                                            pattern = "alpha")) == 0 &
                                                       sum(stringr::str_count(string = chain,
                                                                              pattern = "beta")) == 1 ~ "one_beta_only",
                                                     sum(stringr::str_count(string = chain,
                                                                            pattern = "alpha")) == 1 &
                                                       sum(stringr::str_count(string = chain,
                                                                              pattern = "beta")) == 1 ~ "one_alpha_one_beta",
                                                     TRUE ~ "other")) %>%
    dplyr::mutate(TCR_combination = factor(TCR_combination,
                                           levels = c("one_alpha_one_beta", "one_alpha_only",
                                                      "one_beta_only", "other"))) %>%
    dplyr::ungroup() %>%
    dplyr::select({{identifier}}, TCR_sequence, TCR_combination) %>%
    dplyr::right_join(.data, by = c(identifier_string, "TCR_sequence"))

  return(data_aug)
}
