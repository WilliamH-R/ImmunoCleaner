#' Title
#'
#' @inheritParams add_max_non_specific_binder
#' @inheritParams add_chain_ident_remove_prefix
#'
#' @param file_name The name of the build in data file which is used.
#'
#' @return The same data frame, but with an added column `non_promiscuous_pair`.
#'     It contains the alpha and beta chain in a pair, but only for cells
#'     which are non-promiscuous. Meaning, where there is no doubt about
#'     the pairing of alpha and beta sequences. The indications as to which
#'     chain is which is removed to reduce the number of characters.
#'     It is always noted as alpha;beta.
#'
#' @noRd

add_non_promiscuous_TCR_pairs <- function(.data,
                                          file_name = vdj_v1_hs_aggregated_donor1_binarized_matrix,
                                          replace_pattern = "TR[A|B]:",
                                          replace_with = "") {

  data_aug <-
    .data %>%
    dplyr::left_join({{file_name}} %>%
                       dplyr::select(barcode,
                                     cell_clono_cdr3_aa),
                     by = "barcode") %>%
    dplyr::mutate(non_promiscuous_pair = dplyr::case_when(stringr::str_count(string = cell_clono_cdr3_aa,
                                                                          pattern = "TRA") == 1 &
                                                         stringr::str_count(string = cell_clono_cdr3_aa,
                                                                            pattern = "TRB") == 1 ~ cell_clono_cdr3_aa,
                                                       TRUE ~ NA_character_),
                  dplyr::across(.cols = non_promiscuous_pair,
                                .fns = stringr::str_replace_all,
                                pattern = replace_pattern,
                                replacement = replace_with)) %>%
    dplyr::select(-cell_clono_cdr3_aa)
  return(data_aug)
}
