#' Title
#'
#' @inheritParams run_all_prep
#'
#' @return A pivot longer version of the data with TCR sequences as rows instead
#'     of columns.
#'
#' @family Cleaning functions
#'
#'
pivot_longer_TCR_sequences <- function(.data,
                                       pivot_names = NULL) {

  data_clean <-
    .data %>%
    pivot_longer(matches("cell_clono_cdr3_aa"),
                 names_to = pivot_names,
                 values_to = "TCR_sequence") %>%
    drop_na("TCR_sequence") %>%
    relocate("TCR_sequence",
             .after = donor)

  return(data_clean)
}
