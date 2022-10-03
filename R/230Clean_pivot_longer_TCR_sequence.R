#' Title
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @return A pivot longer version of the data with TCR-sequences as rows instead
#'     of columns.
#'
#' @family Cleaning functions
#' @noRd
#'
#'
pivot_longer_TCR_sequences <- function(.data,
                                       pivot_names = NULL) {

  data_clean <-
    .data %>%
    tidyr::pivot_longer(dplyr::matches("cell_clono_cdr3_aa"),
                        names_to = pivot_names,
                        values_to = "TCR_sequence") %>%
    tidyr::drop_na("TCR_sequence") %>%
    dplyr::relocate("TCR_sequence",
                    .after = donor)

  return(data_clean)
}
