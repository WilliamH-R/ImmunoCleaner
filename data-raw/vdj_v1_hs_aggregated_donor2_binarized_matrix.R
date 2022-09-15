vdj_v1_hs_aggregated_donor2_binarized_matrix <-
  read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor2/vdj_v1_hs_aggregated_donor2_binarized_matrix.csv"),
           show_col_types = FALSE)

usethis::use_data(vdj_v1_hs_aggregated_donor2_binarized_matrix,
                  overwrite = TRUE)
