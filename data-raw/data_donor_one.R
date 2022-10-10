data_donor_one <-
  readr::read_csv("inst/extdata/data_donor_one.csv",
                  show_col_types = FALSE)

usethis::use_data(data_donor_one,
                  overwrite = TRUE)
