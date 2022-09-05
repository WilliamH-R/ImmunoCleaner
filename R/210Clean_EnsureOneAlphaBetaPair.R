EnsureOneAlphaBetaPair <- function(data){ 
  data %>%
    filter(str_count(string = cell_clono_cdr3_aa,
                     pattern = ";") == 1)
}