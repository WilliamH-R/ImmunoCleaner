#' Title
#'
#' @inheritParams run_all_prep
#'
#' @return Return a pivot longer version of the data with UMI counts as rows
#'     instead of columns.
#' 
#' @family Cleaning functions
#'
#'
pivot_longer_allele <- function(.data,
                                allele_pattern = "[A-Z]{5,}"){
  data_clean <-
    .data %>% 
    pivot_longer(matches(allele_pattern,
                         ignore.case = FALSE),
                 names_to = "allele_info",
                 values_to = "UMI_count") %>% 
    filter(UMI_count != 0)
  return(data_clean)
}
