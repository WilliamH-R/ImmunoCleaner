#Add TRUE/FALSE depending on whether they fulfill demands or nor
EvaluateBinder <- function(data,
                           threshold = 10,
                           non_specific_threshold = 5){ 
  data %>% 
    mutate(is_max_binder_specific = case_when(
      max_binder > threshold &
        max_binder > non_specific_threshold*max_non_specific_binder ~ TRUE,
      TRUE ~ FALSE
    ))
}


