logo_plot <- function(.data_aug,
                      chain_filter = "alpha",
                      distinct_by = barcode){
  
  data_model <-
    .data_aug %>% 
    filter(is_binder == TRUE,
           chain == chain_filter,
           str_length(TCR_sequences) == 9) %>% 
    distinct({{distinct_by}},
              .keep_all = TRUE) %>% 
    pull(TCR_sequences) %>% 
    ggseqlogo::ggseqlogo()
  
  return(data_model)
    
}

#The str_length should be removed when sequence alignment works

