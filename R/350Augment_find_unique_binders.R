#' Find TCR-sequences and pMHC which only match with each other once
#'
#' `find_unique_binders()` checks if a pMHC binding to a TCR_sequence only occur
#'     once.
#'
#' @inheritParams add_max_negative_control_binder
#'
#' @return Same data frame as `.data`, but with an added column `unique_binder`.
#'     It contains a boolean. `TRUE` if it is unique, otherwise `FALSE`.
#'
#' @family Preparation functions
#' @noRd
#'

find_unique_binders <- function(.data) {

  data_aug <- .data %>%
    dplyr::add_count(donor,
                     TCR_sequence,
                     pMHC,
                     name = "count") %>%
    dplyr::mutate(unique_binder = dplyr::case_when(count == 1 ~ TRUE,
                                                   TRUE ~ FALSE)) %>%
    dplyr::select(-count)

  return(data_aug)
}
