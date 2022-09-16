#Add TRUE/FALSE depending on whether they fulfill demands or nor
evaluate_binder <- function(data_clean,
                            threshold = 10,
                            non_specific_threshold = 5){ 
  
  data_augment <-
    data_clean %>% 
    group_by(barcode) %>% 
    mutate(is_binder = case_when(UMI_count > threshold & 
                                   UMI_count > non_specific_threshold * max_non_specific_binder &
                                   UMI_count == max(UMI_count,
                                                    na.rm = TRUE) ~ TRUE,
                                 TRUE ~ FALSE))
  return(data_augment)
}

