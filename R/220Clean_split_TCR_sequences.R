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
                                separator = ";",
                                replace_pattern = "TR[A|B]:",
                                replace_with = "") {
  data_clean <-
    .data %>%
    dplyr::mutate(non_promiscuous_pair = dplyr::case_when(stringr::str_count(string = cell_clono_cdr3_aa,
                                                                             pattern = "TRA") == 1 &
                                                            stringr::str_count(string = cell_clono_cdr3_aa,
                                                                               pattern = "TRB") == 1 ~ cell_clono_cdr3_aa,
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
