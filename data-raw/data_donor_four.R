data_donor_four <-
  readr::read_csv("inst/extdata/data_donor_four.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(data_donor_four,
                  overwrite = TRUE)
