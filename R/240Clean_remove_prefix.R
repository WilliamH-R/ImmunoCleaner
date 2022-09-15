#' Title
#'
#' @inheritParams RunAllClean 
#'
#' @return The input data, but with the prefix "TRA" and "TRB" removed
#' 
#' @family Cleaning functions
#'
#'
add_TCR_type_remove_prefix <- function(data){
  data_clean <-
    data %>% 
    mutate(chain = case_when(str_detect(string = TCR_sequences,
                                        pattern = "TRA:") ~ "alpha",
                             str_detect(string = TCR_sequences,
                                        pattern = "TRB:") ~ "beta")) %>% 
    mutate(across(.cols = TCR_sequences,
                  .fns = str_replace,
                  pattern = "TR[A|B]:",
                  replacement = "")) %>% 
    relocate(chain,
             .after = TCR_sequences)
  return(data_clean)
}


