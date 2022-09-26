data %>% 
  dplyr::filter(is_binder == TRUE) %>% 
  dplyr::group_by(barcode) %>% 
  dplyr::distinct(allele_info) %>% 
  dplyr::count() %>% 
  dplyr::filter(n > 1) %>% 
  View()
