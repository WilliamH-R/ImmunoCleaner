#' Title
#'
#' @inheritParams  run_all_prep 
#' 
#' @param identifier The column in the data set which identifies each 
#'     experiment. Default is set to `barcode`.
#'
#' @return The same data frame, but with an added column. The columns includes
#'     an integer for the maximum UMI-count of all non-specific binders for
#'     each experiment (an experiment is a unique barcode).
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

  data_clean <-
    .data %>% 
    dplyr::group_by({{identifier}}) %>% 
    dplyr::mutate(max_non_specific_binder = dplyr::case_when(is.element(allele_info,
                                                                        non_specific_binders_vector) == TRUE ~ UMI_count,
                                                             TRUE ~ 0),
                  max_non_specific_binder = max(max_non_specific_binder)) %>% 
    dplyr::ungroup()

  return(data_clean)
}