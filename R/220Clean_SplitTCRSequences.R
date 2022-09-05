SplitTCRSequences <- function(data){
  data %>% 
    separate(col = cell_clono_cdr3_aa,
             into = c("TRA_aa", "TRB_aa"),
             sep = ";") %>% 
    
    separate(col = cell_clono_cdr3_nt,
             into = c("TRA_nt", "TRB_nt"),
             sep = ";")
}
