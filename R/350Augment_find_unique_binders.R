#' Find TCR-sequences and pMHC which only match with each other once
#'
#' `check_if_HLA_match()` simply checks if the noted allele for a barcode match
#'     the noted HLA-type.
#'
#' @inheritParams add_max_non_specific_binder
#'
#' @return Same data frame as `.data`, but with an added column `HLA_match`.
#'     It contains a boolean. `TRUE` if the HLA noted in `allele` is a match.
#'
#' @family Preparation functions
#' @noRd
#'

find_unique_binders <- function(.data) {

  data_aug <- .data %>%
    dplyr::group_by(donor, TCR_sequence, pMHC) %>%
    dplyr::add_count(name = "count") %>%
    dplyr::ungroup() %>%
    dplyr::mutate(unique_binder = dplyr::case_when(count == 1 ~ TRUE,
                                                   TRUE ~ FALSE)) %>%
    dplyr::select(-count)

  return(data_aug)
}
