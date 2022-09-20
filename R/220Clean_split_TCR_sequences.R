#' Title
#'
#' @inheritParams run_all_clean
#'
#' @return Returns the input data, but "cell_clono_cdr3_aa" is split for each
#'     TCR-sequence.
#' 
#' @family Cleaning functions
#'
#'
split_TCR_sequences <- function(.data,
                                TCR_col = cell_clono_cdr3_aa,
                                separator = ";"){
  data_clean <-
    .data %>% 
    separate(col = {{TCR_col}},
             into = str_c("cell_clono_cdr3_aa_1",
                          seq(1:8),
                          sep = "_"),
             sep = separator,
             fill = "right") %>% 
    select(where(~!all(is.na(.))))
  
  return(data_clean)
}


