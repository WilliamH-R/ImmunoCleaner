data_donor_four_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor4/vdj_v1_hs_aggregated_donor4_binarized_matrix.csv"),
                  show_col_types = FALSE)

usethis::use_data(data_donor_four_raw,
                  overwrite = TRUE)
