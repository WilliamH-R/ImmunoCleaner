RunAllClean <- function(data){ 
  data %>% 
    EnsureOneAlphaBetaPair() %>% 
    SplitTCRSequences() %>% 
    RemovePrefix() %>% 
    RemoveBinders()
    
}