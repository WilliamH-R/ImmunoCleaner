#' Identify non-specific binder with highest UMI-count
#'
#' `add_max_non_specific_binder()` adds a new column `max_non_specific_binder` by
#'     checking if a pMHC is in a list of known non-specific pMHC. If yes, add
#'     the respective UMI-count in that new column, otherwise set to 0. If a
#'     TCR-sequence bound multiple non-specific binders, only choose the
#'     highest count.
#'
#' @param .data A data frame which has been cleaned, and is now ready for
#'     augmentation.
#'
#' @param identifier The column in the data set which identifies each
#'     experiment. Default is set to `barcode`.
#'
#' @return `.data` but with an added column. The column includes an integer for
#'     the maximum UMI-count out of all non-specific binders for each experiment.
#'
#' @family Preparation functions
#' @noRd
#'

add_max_non_specific_binder <- function(.data,
                                        identifier = barcode){
  # Tibble of the non-specific binders
  non_specific_binders_vector <- c("A0101_VTEHDTLLY_IE-1_CMV",
                                   "A0201_KVAELVHFL_MAGE-A3_Cancer",
                                   "A0201_LLMGTLGIVC_HPV-16E7_82-91",
                                   "A0201_CLGGLLTMV_LMP-2A_EBV",
                                   "A0201_NLVPMVATV_pp65_CMV",
                                   "A0201_KLQCVDLHV_PSA146-154",
                                   "B0702_TPRVTGGGAM_pp65_CMV")

  data_aug <-
    .data %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::mutate(max_non_specific_binder = dplyr::case_when(is.element(pMHC,
                                                                        non_specific_binders_vector) == TRUE ~ UMI_count,
                                                             TRUE ~ 0),
                  max_non_specific_binder = max(max_non_specific_binder)) %>%
    dplyr::ungroup()

  return(data_aug)
}
