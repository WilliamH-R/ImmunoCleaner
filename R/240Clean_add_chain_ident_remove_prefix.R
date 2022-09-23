#' Title
#'
#' @inheritParams run_all_prep
#'
#' @return Return the input data with a column added indicating the chain,
#'     and with the prefix "TRA" and "TRB" removed.
#'
#' @family Cleaning functions
#'
#'
add_chain_ident_remove_prefix <- function(.data,
                                          replace_pattern = "TR[A|B]:",
                                          replace_with = "") {
  data_clean <-
    .data %>%
    mutate(chain = case_when(str_detect(string = TCR_sequence,
                                        pattern = "TRA:") ~ "alpha",
                             str_detect(string = TCR_sequence,
                                        pattern = "TRB:") ~ "beta"),
           across(.cols = TCR_sequence,
                  .fns = str_replace,
                  pattern = replace_pattern,
                  replacement = replace_with)) %>%
    relocate(chain,
             .after = TCR_sequence)
  return(data_clean)
}