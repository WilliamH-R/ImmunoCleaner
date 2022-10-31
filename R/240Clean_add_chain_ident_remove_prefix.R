#' Add chain identifier and remove prefix of TCR-sequences
#'
#' By using RegEx, `add_chain_ident_remove_prefix()` adds a column, `chain`, to
#'     categorise the chain into being either an alpha or beta chain. After,
#'     the prefix `replace_pattern` is removed since it is no longer needed.
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @inheritParams find_non_promiscuous_split_TCR_sequences
#'
#' @return Return `.data` with a column added indicating the chain type,
#'     and with the prefix "TRA" and "TRB" removed.
#'
#' @family Preparation functions
#' @export
#' @noRd
#'

add_chain_ident_remove_prefix <- function(.data,
                                          replace_pattern = "TR[A|B]:",
                                          replace_with = "") {
  data_clean <-
    .data %>%
    dplyr::mutate(chain = dplyr::case_when(stringr::str_detect(string = TCR_sequence,
                                                               pattern = "TRA:") ~ "alpha",
                                           stringr::str_detect(string = TCR_sequence,
                                                               pattern = "TRB:") ~ "beta"),
           dplyr::across(.cols = TCR_sequence,
                         .fns = stringr::str_replace,
                         pattern = replace_pattern,
                         replacement = replace_with)) %>%
    dplyr::relocate(chain,
                     .after = TCR_sequence)
  return(data_clean)
}
