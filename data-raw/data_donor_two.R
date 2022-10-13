data_donor_two <-
  readr::read_csv("inst/extdata/data_donor_two.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_two,
                  overwrite = TRUE)
