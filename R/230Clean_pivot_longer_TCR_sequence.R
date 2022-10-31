#' Pivot longer TCR-sequences
#'
#' `pivot_longer_TCR_sequences()` pivot longer alle the TCR-sequence columns created
#'     by `?find_non_promiscuous_split_TCR_sequences`. After, all `NA` values are
#'     dropped to reduce dimensions.
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @param pivot_names Name of column to pivot the names to. Default is `NULL` as
#'     the names aren't used.
#'
#' @return A pivot longer version of `.data` with TCR-sequences as rows instead
#'     of columns.
#'
#' @family Preparation functions
#' @noRd
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
