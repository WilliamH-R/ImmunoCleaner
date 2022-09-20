add_max_non_specific_binder <- function(data){
  
  # Tibble of the non-specific binders
  non_specific_binders_vector <- c("A0101_VTEHDTLLY_IE-1_CMV",
                                   "A0201_KVAELVHFL_MAGE-A3_Cancer",
                                   "A0201_LLMGTLGIVC_HPV-16E7_82-91",
                                   "A0201_CLGGLLTMV_LMP-2A_EBV",
                                   "A0201_NLVPMVATV_pp65_CMV",
                                   "A0201_KLQCVDLHV_PSA146-154",
                                   "B0702_TPRVTGGGAM_pp65_CMV")

  data_clean %>% 
    group_by(barcode) %>% 
    mutate(max_non_specific_binder = case_when(is.element(allele_info,
                                                          non_specific_binders_vector) == TRUE ~ UMI_count,
                                               TRUE ~ 0),
           max_non_specific_binder = max(max_non_specific_binder)) %>% 
    relocate(barcode,
             .before = allele_info)

  return(data_clean)
}