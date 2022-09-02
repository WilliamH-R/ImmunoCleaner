#library("tidyverse")

list.files("data-raw", full.names = TRUE) %>%
  stringr::str_extract(".+\\.R") %>% 
  na.omit() %>% 
  purrr::walk(source)