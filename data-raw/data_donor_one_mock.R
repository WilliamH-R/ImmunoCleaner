data_donor_one_mock <-
  readr::read_csv("inst/extdata/data_donor_one_mock.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_one_mock,
                  overwrite = TRUE)
