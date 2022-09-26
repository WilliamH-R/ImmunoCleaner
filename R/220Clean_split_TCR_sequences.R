#' Title
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @return Returns the input data, but "cell_clono_cdr3_aa" is split for each
#'     TCR-sequence.
#' 
#' @family Cleaning functions
#' @noRd
#'
#'
split_TCR_sequences <- function(.data,
                                TCR_col = cell_clono_cdr3_aa,
                                separator = ";") {
  data_clean <-
    .data %>%
    tidyr::separate(col = {{TCR_col}},
                    into = stringr::str_c("cell_clono_cdr3_aa_1",
                                          seq(1:8),
                                          sep = "_"),
                    sep = separator,
                    fill = "right") %>%
    dplyr::select(where(~!all(is.na(.))))

  return(data_clean)
}