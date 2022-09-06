AddNameAndValueOfBinders <- function(data){
  # Tibble of the non-specific binders
  non_specific_binders <- c("A0101_VTEHDTLLY_IE-1_CMV",
                            "A0201_KVAELVHFL_MAGE-A3_Cancer",
                            "A0201_LLMGTLGIVC_HPV-16E7_82-91",
                            "A0201_CLGGLLTMV_LMP-2A_EBV",
                            "A0201_NLVPMVATV_pp65_CMV",
                            "A0201_KLQCVDLHV_PSA146-154",
                            "B0702_TPRVTGGGAM_pp65_CMV")
  non_specific_binders <- tibble(names = non_specific_binders)
  
  # Tibble with names of all binders, including row numbers
  all_binders <- data %>% 
    RemoveBinders() %>% 
    select(matches("[A-Z]{5,}",
                   ignore.case = FALSE)) %>%
    colnames() %>% 
    as_tibble_col(column_name = "names") %>% 
    mutate(row_number())
  
  # Inner join by the names of the binders
  non_specific_binders_index <-
    all_binders %>% 
    inner_join(non_specific_binders) %>% 
    pull("row_number()")
  
  # Find the name and value of highest binder for each row, along with the 
  # maximum value of all the non-specific binders also for each row
  data <- data %>% 
    RemoveBinders() %>% 
    select(matches("[A-Z]{5,}",
                   ignore.case = FALSE)) %>%
    rowwise() %>%
    mutate(max_non_specific_binder = max(across(non_specific_binders_index)),
           max_binder = max(across()),
           max_binder_name = names(.)[which.max(c_across(everything()))],
           max_binder_category = str_replace(max_binder_name,
                                             "[A|B]\\d{4}_[A-Z]{5,}_|NR\\(B0801\\)",
                                             ""))
  
}