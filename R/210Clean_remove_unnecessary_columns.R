#' Title
#'
#' @param data A data structure which need to be cleaned.
#'
#' @return Returns the input data, but without all the binding assessments and
#'     nucleotide sequences
#' 
#' @family Cleaning functions
#' @noRd
#'
#'
remove_unnecessary_columns <- function(.data,
                                       col1 = "_binder",
                                       col2 = "cell_clono_cdr3_nt"){ 
  data_clean <-
    .data %>% 
    dplyr::select(-dplyr::matches(col1),
                  -dplyr::matches(col2))
  return(data_clean)
}
