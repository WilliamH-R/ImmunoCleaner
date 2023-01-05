data_combined_tidy <- dplyr::bind_rows(data_donor_one_raw,
                                       data_donor_two_raw,
                                       data_donor_three_raw,
                                       data_donor_four_raw) %>%
  run_all_prep()

usethis::use_data(data_combined_tidy,
                  overwrite = TRUE)
