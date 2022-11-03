aux_alleles_status_each_donor <-
  readr::read_csv("inst/extdata/aux_alleles_status_each_donor.csv.gz",
                  show_col_types = FALSE)

usethis::use_data(aux_alleles_status_each_donor,
                  overwrite = TRUE)
