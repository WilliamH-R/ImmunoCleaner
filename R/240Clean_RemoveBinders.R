EnsureOneAlphaBetaPair <- function(data){ 
  data %>% 
    select(-matches("_binder")) %>% 
    View()
}