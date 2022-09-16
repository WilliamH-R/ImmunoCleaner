#' Title
#'
#' @inheritParams run_all_clean
#'
#' @return Return a pivot longer version of the data with UMI counts as rows
#'     instead of columns.
#' 
#' @family Cleaning functions
#'
#'
pivot_longer_allele <- function(data){
  data_clean <-
    data %>% 
    pivot_longer(matches("[A-Z]{5,}",
                         ignore.case = FALSE),
                 names_to = "allele_info",
                 values_to = "UMI_count") %>% 
    filter(UMI_count != 0)
  return(data_clean)
}
