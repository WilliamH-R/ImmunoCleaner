#' Title
#'
#' @inheritParams RunAllClean
#'
#' @return The input data set, but only observations with exactly one TRA and TRB
#' 
#' @family Cleaning functions
#' 
#'
ensure_one_alpha_beta_pair <- function(data){ 
  data %>%
    filter(str_count(string = cell_clono_cdr3_aa,
                     pattern = ";") == 1)
  return(data_clean)
}