summarise_binders <- function(data, var1 = barcode){ 
  data_augment <-
    data %>% 
    EvaluateBinder() %>% 
    filter(is_binder == TRUE) %>%
    select({{var1}}, allele_info, is_binder) %>% 
    group_by(allele_info) %>%
    count()
  return(data_augment)
}

# Non-standard evaluation