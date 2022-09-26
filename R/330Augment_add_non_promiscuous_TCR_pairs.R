#' Title
#'
#' @inheritParams add_max_non_specific_binder
#' 
#' @param file_name The name of the build in data file which is used.
#'
#' @return The same data frame, but with an added column `non_promiscuous_pair`.
#'     It contains the alpha and beta chain in a pair, but only for cells
#'     which are non-promiscuous. Meaning, where there is no doubt about
#'     the pairing of alpha and beta sequences.
#'     
#' @noRd

add_non_promiscuous_TCR_pairs <- function(.data,
                                          file_name = vdj_v1_hs_aggregated_donor1_binarized_matrix) {

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
                                                       TRUE ~ NA_character_)) %>% 
    dplyr::select(-cell_clono_cdr3_aa)
  return(data_aug)
}