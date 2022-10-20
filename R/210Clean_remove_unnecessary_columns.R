#' Remove columns via string matching
#'
#' `remove_unnecessary_columns()` removes all the columns of the input data frame
#'    which can be matched to the `cols` argument.
#'
#' @param .data A data structure which needs to be cleaned.
#'
#' @param cols A vector of strings with columns to remove. The selection is done
#'    through `dplyr`'s `matches` function.
#'
#' @return A data frame as the same type as `.data`, but without all the binding
#'    assessments and nucleotide sequences.
#'
#' @family Preparation functions
#' @noRd
#'

remove_unnecessary_columns <- function(.data,
                                       cols = c("_binder","cell_clono_cdr3_nt")) {
  data_clean <-
    .data %>%
    dplyr::select(-dplyr::matches(cols))
  return(data_clean)
}
