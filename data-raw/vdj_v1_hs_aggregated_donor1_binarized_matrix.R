vdj_v1_hs_aggregated_donor1_binarized_matrix <-
  read_csv("data-raw/vdj_v1_hs_aggregated_donor1_binarized_matrix.csv",
           show_col_types = FALSE)
usethis::use_data(vdj_v1_hs_aggregated_donor1_binarized_matrix,
                  overwrite = TRUE)
