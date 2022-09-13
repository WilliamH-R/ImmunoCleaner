#Add TRUE/FALSE depending on whether they fulfill demands or nor
EvaluateBinder <- function(data,
                           threshold = 10,
                           non_specific_threshold = 5){ 
  
  data_clean %>% 
    group_by(barcode) %>% 
    mutate(is_binder = case_when(UMI_count > threshold & 
                                   UMI_count > non_specific_threshold * max(non_specific_binder_UMI_count,
                                                                            na.rm = TRUE) &
                                   UMI_count == max(UMI_count,
                                                    na.rm = TRUE) ~ TRUE,
                                 TRUE ~ FALSE))
}

