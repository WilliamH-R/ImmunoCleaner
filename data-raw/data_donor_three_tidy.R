data_donor_three_tidy <-
  readr::read_csv("inst/extdata/data_donor_three_tidy.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_three_tidy,
                  overwrite = TRUE)
