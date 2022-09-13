summarise_binders <- function(data){ 
  data %>% 
    evaluate_binder() %>% 
    filter(is_binder == TRUE) %>%
    select(barcode, allele_info, is_binder) %>% 
    group_by(allele_info) %>%
    count() %>%
    View()
  return(data_clean)
}
