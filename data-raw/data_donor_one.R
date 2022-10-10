data_donor_one <-
  vdj_v1_hs_aggregated_donor1_binarized_matrix %>%
  run_all_prep()

usethis::use_data(data_donor_one,
                  overwrite = TRUE)
