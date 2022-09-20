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
remove_unnecessary_columns <- function(.data,
                                       col1 = "_binder",
                                       col2 = "cell_clono_cdr3_nt"){ 
  data_clean <-
    .data %>% 
    select(-matches(col1),
           -matches(col2))
  return(data_clean)
}
