#' Title
#'
#' @inheritParams RunAllClean 
#'
#' @return Return the input data with a column added indicating the chain, 
#'     and with the prefix "TRA" and "TRB" removed.
#' 
#' @family Cleaning functions
#'
#'
add_chain_ident_remove_prefix <- function(data){
  data_clean <-
    data %>% 
    mutate(chain = case_when(str_detect(string = TCR_sequences,
                                        pattern = "TRA:") ~ "alpha",
                             str_detect(string = TCR_sequences,
                                        pattern = "TRB:") ~ "beta"),
           across(.cols = TCR_sequences,
                  .fns = str_replace,
                  pattern = "TR[A|B]:",
                  replacement = "")) %>%
    relocate(chain,
             .after = TCR_sequences)
  return(data_clean)
}


