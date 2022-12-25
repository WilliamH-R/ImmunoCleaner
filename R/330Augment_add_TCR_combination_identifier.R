#' Categorise TCR-sequence combinations
#'
#' `add_TCR_combination_identifier()` counts occurrences of the string `"alpha"`
#'    and `"beta"` in the column `chain` for each `identifier`. Based on the count,
#'    the `identifier` is put into one of the below-written categories:
#'    * `"one_alpha_only"`
#'    * `"one_beta_only"`
#'    * `"one_alpha_one_beta"`
#'    * `"other"`
#'
#' @inheritParams add_max_negative_control_binder
#'
#' @param identifier_string Same as `identifier`, but supplied as a string.
#'
#' @return Same data frame as `.data`, but with an added column `TCR_combination`.
#'     It contains a categorical value for a specific combination of alpha
#'     and beta sequence counts:
#'     * If only an alpha sequence, then `"one_alpha_only"`
#'     * If only a beta sequence, then `"one_beta_only"`
#'     * If one alpha- and beta sequence, then `"one_alpha_one_beta"`
#'     * Otherwise will by noted as `"other"`
#'
#' @family Preparation functions
#' @noRd
#'

add_TCR_combination_identifier <- function(.data,
                                           identifier = barcode,
                                           identifier_string = "barcode") {
  data_aug <-
    .data %>%
    dplyr::group_by(donor,
                    {{identifier}}) %>%
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
    dplyr::select(donor, {{identifier}}, TCR_sequence, TCR_combination) %>%
    dplyr::right_join(.data, by = c("donor", identifier_string, "TCR_sequence"))

  return(data_aug)
}
