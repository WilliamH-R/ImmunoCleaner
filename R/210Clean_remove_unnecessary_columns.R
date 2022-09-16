#' Title
#'
#' @inheritParams run_all_clean 
#'
#' @return Returns the input data, but without all the binding assessments and
#'     nucleotide sequences
#' 
#' @family Cleaning functions
#'
#'
remove_unnecessary_columns <- function(data,
                                       column1 = "_binder",
                                       column2 = "cell_clono_cdr3_nt"){ 
  data_clean <-
    data %>% 
    select(-matches(column1),
           -matches(column2))
  return(data_clean)
}
