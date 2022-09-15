#' Title
#'
#' @inheritParams RunAllClean 
#'
#' @return The input data, but each TCR-pair is split into a TRA and TRB column
#' 
#' @family Cleaning functions
#'
#'
split_TCR_sequences <- function(data){
  data_clean <-
    data %>% 
    separate(col = cell_clono_cdr3_aa,
             into = c("cell_clono_cdr3_aa_1", "cell_clono_cdr3_aa_2",
                      "cell_clono_cdr3_aa_3","cell_clono_cdr3_aa_4",
                      "cell_clono_cdr3_aa_5","cell_clono_cdr3_aa_6",
                      "cell_clono_cdr3_aa_7","cell_clono_cdr3_aa_8"),
             sep = ";",
             fill = "right") %>% 
    select(where(~!all(is.na(.))))
  return(data_clean)
}
