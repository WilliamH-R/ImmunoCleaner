remove_binders <- function(data){ 
  data %>% 
    select(-matches("_binder"))
  return(data_clean)
}