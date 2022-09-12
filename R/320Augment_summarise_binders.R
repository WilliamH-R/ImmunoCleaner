EvaluateBinder(data_clean) %>% filter(is_binder == TRUE) %>% select(barcode, allele_info, is_binder) %>%  group_by(allele_info) %>% count() %>% View()
