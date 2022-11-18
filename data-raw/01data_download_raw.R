data_donor_one_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor1/vdj_v1_hs_aggregated_donor1_binarized_matrix.csv"),
                  show_col_types = FALSE)

data_donor_two_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor2/vdj_v1_hs_aggregated_donor2_binarized_matrix.csv"),
                  show_col_types = FALSE)

data_donor_three_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor3/vdj_v1_hs_aggregated_donor3_binarized_matrix.csv"),
                  show_col_types = FALSE)

data_donor_four_raw <-
  readr::read_csv(url("https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor4/vdj_v1_hs_aggregated_donor4_binarized_matrix.csv"),
                  show_col_types = FALSE)

usethis::use_data(data_donor_one_raw,
                  data_donor_two_raw,
                  data_donor_three_raw,
                  data_donor_four_raw,
                  overwrite = TRUE,
                  internal = TRUE)
