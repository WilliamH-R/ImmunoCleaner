#' Tidy the pMHC names by splitting based on separator
#'
#' `tidy_pMHC_names()` tidies the pMHC column by splitting it based on `separator`
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @param names_into Names of columns which pMHC should be split into.
#'
#' @param separator Separator used to split pMHC into `names_into`
#'
#' @return Return `.data` with the pMHC column split into three new:
#' * allele
#' * peptide
#' * peptide_source
#' While keeping the original column to use for modelling.
#'
#' @family Preparation functions
#' @noRd
#'

tidy_pMHC_names <- function(.data,
                            names_into = c("allele", "peptide", "peptide_source"),
                            separator = "_"){
  data_clean <-
    .data %>%
    tidyr::separate(col = "pMHC",
                    into = names_into,
                    sep = separator,
                    extra = "merge",
                    remove = FALSE)
  return(data_clean)
}
