#' Pivot longer pMHC names and UMI-count
#'
#' `pivot_longer_pMHC()` makes `.data` long by pivotting the UMI-counts for each
#'     pMHC, and thereafter removing zero counts.
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @param pMHC_pattern A string RegEx pattern recognising pMHC columns.
#'
#' @return Return a pivot longer version of the data with UMI-counts as rows
#'     instead of columns.
#'
#' @family Preparation functions
#' @noRd
#'

pivot_longer_pMHC <- function(.data,
                              pMHC_pattern = "[A-Z]{5,}"){
  data_clean <-
    .data %>%
    tidyr::pivot_longer(dplyr::matches(pMHC_pattern,
                                       ignore.case = FALSE),
                        names_to = "pMHC",
                        values_to = "UMI_count") %>%
    dplyr::filter(UMI_count != 0)
  return(data_clean)
}
