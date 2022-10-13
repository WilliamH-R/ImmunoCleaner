data_donor_three <-
  readr::read_csv("inst/extdata/data_donor_three.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_three,
                  overwrite = TRUE)
