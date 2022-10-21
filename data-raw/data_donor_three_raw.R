data_donor_three_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor3/vdj_v1_hs_aggregated_donor3_binarized_matrix.csv"),
                  show_col_types = FALSE)

usethis::use_data(data_donor_three_raw,
                  overwrite = TRUE)
