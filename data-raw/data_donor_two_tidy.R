data_donor_two_tidy <-
  readr::read_csv("inst/extdata/data_donor_two_tidy.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_two_tidy,
                  overwrite = TRUE)
