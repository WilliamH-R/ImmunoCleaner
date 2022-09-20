#' Title
#'
#' @inheritParams run_all_clean 
#'
#' @return Return a data frame with the "allele_info" split into three columns:
#' * "allele"
#' * "peptide"
#' * "peptide_source"
#' 
#' @family Cleaning functions
#'
#'
tidy_allele_names <- function(.data,
                              names_into = c("allele", "peptide", "peptide_source"),
                              separator = "_"){ 
  data_clean <- 
    .data %>% 
    separate(col = "allele_info",
             into = names_into,
             sep = separator,
             extra = "merge")
  return(data_clean)
}
