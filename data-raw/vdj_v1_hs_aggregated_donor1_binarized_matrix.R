vdj_v1_hs_aggregated_donor1_binarized_matrix <-
  read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor1/vdj_v1_hs_aggregated_donor1_binarized_matrix.csv"),
           show_col_types = FALSE)

usethis::use_data(vdj_v1_hs_aggregated_donor1_binarized_matrix,
                  overwrite = TRUE)