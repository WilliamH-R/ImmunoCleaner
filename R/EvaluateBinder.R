threshold <- 10
negative_threshold <- 5

vdj_v1_hs_aggregated_donor1_binarized_matrix %>% 
  select(matches("[A-Z]{5,}",
                 ignore.case = FALSE)) %>% 
  select(-matches("_binder")) %>% 
  rowwise() %>%
  mutate(max_binder = max()) %>% 
  View()
