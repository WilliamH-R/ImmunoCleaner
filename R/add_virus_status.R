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

  lookup <- tibble::tribble(~donor, ~peptide_source, ~virus_status,
                            "donor1", "CMV", "UNKNOWN",
                            "donor1", "EBV", "UNKNOWN",
                            "donor1", "HIV", "NEGATIVE",
                            "donor1", "HBV", "NEGATIVE",
                            "donor1", "HCV", "NEGATIVE",
                            "donor2", "CMV", "UNKNOWN",
                            "donor2", "EBV", "UNKNOWN",
                            "donor2", "HIV", "NEGATIVE",
                            "donor2", "HBV", "NEGATIVE",
                            "donor2", "HCV", "NEGATIVE",
                            "donor3", "CMV", "POSITIVE",
                            "donor3", "EBV", "NEGATIVE",
                            "donor3", "HIV", "NEGATIVE",
                            "donor3", "HBV", "NEGATIVE",
                            "donor3", "HCV", "NEGATIVE",
                            "donor4", "CMV", "NEGATIVE",
                            "donor4", "EBV", "NEGATIVE",
                            "donor4", "HIV", "NEGATIVE",
                            "donor4", "HBV", "NEGATIVE",
                            "donor4", "HCV", "NEGATIVE",
  )



  return(data_aug)
}
