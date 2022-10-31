#' Tidy TCR-sequences and find non-promiscuous TCR-pairs
#'
#' `find_non_promiscuous_split_TCR_sequences()` start by adding a column to indicate
#'     non-promiscuous TCR-sequences (meaning, they have only one alpha and one
#'     beta chain). After, `TCR_col` is split based on `separator` to make it tidy.
#'     Lastly, the prefix `replace_pattern` is removed by replacing with `replace_with`.
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @param TCR_col Name of columns with TCR-sequences. Default is set to
#'     `cell_clono_cdr3_aa` as this is the name in the original data set.
#'
#' @param separator Sign used to separate alpha and beta sequences. Default is
#'     `;` as this is the sign used in the original data set.
#'
#' @param replace_pattern RegEx pattern that needs to be replaced. Defaults is
#'     `TR[A|B]` as this is the prefix which needs to be removed in the original
#'      data set.
#'
#' @param replace_with String which is replaced with. Default is an empty string.
#'
#' @return A data frame with the same type as `.data`, but `TCR_col` is split
#'     for each TCR-sequence.
#'
#' @family Preparation functions
#' @export
#' @noRd
#'

find_non_promiscuous_split_TCR_sequences <- function(.data,
                                                     TCR_col = cell_clono_cdr3_aa,
                                                     separator = ";",
                                                     replace_pattern = "TR[A|B]:",
                                                     replace_with = "") {
  data_clean <-
    .data %>%
    dplyr::mutate(non_promiscuous_pair = dplyr::case_when(stringr::str_count(string = {{TCR_col}},
                                                                             pattern = "TRA") == 1 &
                                                            stringr::str_count(string = {{TCR_col}},
                                                                               pattern = "TRB") == 1 ~ {{TCR_col}},
                                                          TRUE ~ NA_character_),
                  dplyr::across(.cols = non_promiscuous_pair,
                                .fns = stringr::str_replace_all,
                                pattern = replace_pattern,
                                replacement = replace_with)) %>%
    tidyr::separate(col = {{TCR_col}},
                    into = stringr::str_c("cell_clono_cdr3_aa_1",
                                          seq(1:8),
                                          sep = "_"),
                    sep = separator,
                    fill = "right") %>%
    dplyr::select(where(~!all(is.na(.))))

  return(data_clean)
}
