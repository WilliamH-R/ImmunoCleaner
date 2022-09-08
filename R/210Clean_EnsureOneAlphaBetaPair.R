#' Title
#'
#' @inheritParams RunAllClean
#'
#' @return The input data set, but only observations whith exactly one TRA and TRB
#' 
#' @family Cleaning functions
#' 
#' @export
#'
EnsureOneAlphaBetaPair <- function(data){ 
  data %>%
    filter(str_count(string = cell_clono_cdr3_aa,
                     pattern = ";") == 1)
}