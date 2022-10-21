data_donor_one_raw_mock <-
  readr::read_csv("inst/extdata/data_donor_one_raw_mock.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_one_raw_mock,
                  overwrite = TRUE)
