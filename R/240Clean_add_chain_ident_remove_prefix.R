#' Title
#'
#' @inheritParams run_all_prep
#'
#' @return Return the input data with a column added indicating the chain,
#'     and with the prefix "TRA" and "TRB" removed.
#'
#' @family Cleaning functions
#' @noRd
#'
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