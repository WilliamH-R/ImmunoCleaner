#' Check if binding event match HLA-typing
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

check_if_HLA_match <- function(.data) {

  tribble(~donor, ~allele, ~match,
          "donor1", "A0201", "1",
          )

  lookup <- list("donor1" = list("A" = c("A0201", "A1101"), "B" = c("B3501", "UNKNOWN")),
                 "donor2" = list("A" = c("A0201", "A0101"), "B" = c("B0801", "UNKNOWN")),
                 "donor3" = list("A" = c("A2402", "A2902"), "B" = c("B3502", "B4403")),
                 "donor4" = list("A" = c("A0301", "A0301"), "B" = c("B0702", "B5701")))


  data_aug <- .data %>%
    dplyr::rowwise() %>%
    dplyr::mutate(HLA_match = dplyr::case_when(allele %in% lookup[[donor]][["A"]] ~ "TRUE",
                                               allele %in% lookup[[donor]][["B"]] ~ "TRUE",
                                               stringr::str_starts(allele, "A") &
                                                 "UNKNOWN" %in% lookup[[donor]][["A"]] ~ "UNKNOWN",
                                               stringr::str_starts(allele, "B") &
                                                 "UNKNOWN" %in% lookup[[donor]][["B"]] ~ "UNKNOWN",
                                               TRUE ~ "FALSE"
                                               )) %>%
    dplyr::ungroup()

  return(data_aug)
}
