#' Check if binding event match HLA-typing
#'
#' `check_if_HLA_match()` simply checks if the noted allele for a barcode match the
#'     noted HLA-type.
#'
#' @inheritParams add_max_non_specific_binder
#'
#' @return Same data frame as `.data`, but with an added column `HLA_match`.
#'     It contains a boolean. `TRUE` if the HLA noted in `allele` is a match.
#'
#' @family Preparation functions
#' @noRd
#'

check_if_HLA_match <- function(.data) {

  if (stringr::str_detect(.data$donor[1],
                           "donor1")) {
    HLA_A_typing <- c("A0201", "A1101", "B3501")
    HLA_B_typing <- c("B3501")
  } else if (stringr::str_detect(.data$donor[1],
                                  "donor2")) {
    HLA_A_typing <- c("A0201", "A0101", "B0801")
    HLA_B_typing <- c("B0801")
  } else if (stringr::str_detect(.data$donor[1],
                                 "donor3")) {
    HLA_A_typing <- c("A2402", "A2902", "B3502", "B4403")
    HLA_B_typing <- c("B3502", "B4403")
  } else {
    HLA_A_typing <- c("A0301", "A0301", "B0702", "B5701")
    HLA_B_typing <- c("B0702", "B5701")
  }


  data_aug <-
    .data %>%
    dplyr::mutate(HLA_match = dplyr::case_when(allele %in% HLA_A_typing == TRUE ~ TRUE,
                                               TRUE ~ FALSE))

  return(data_aug)
}
