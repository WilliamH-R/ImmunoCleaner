#' Title
#'
#' @inheritParams run_all_clean 
#'
#' @return A pivot longer version of the data with TCR sequences as rows instead
#'     of columns.
#' 
#' @family Cleaning functions
#'
#'
pivot_longer_TCR_sequences <- function(data){
  data_clean <-
    data %>% 
    pivot_longer(matches("cell_clono_cdr3_aa"),
                 names_to = NULL,
                 values_to = "TCR_sequences") %>% 
    drop_na(TCR_sequences) %>% 
    relocate(TCR_sequences,
             .after = donor)
  return(data_clean)
}
