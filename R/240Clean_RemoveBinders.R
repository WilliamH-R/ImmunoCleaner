RemoveBinders <- function(data){ 
  data %>% 
    select(-matches("_binder"))
}