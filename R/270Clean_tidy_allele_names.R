#' Title
#'
#' @inheritParams run_all_clean 
#'
#' @return Return a data frame with the "allele_info" split into three variables:
#' * "allele"
#' * "peptide"
#' * "peptide_source"
#' While keeping the original variable to use for modelling.
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
             extra = "merge",
             remove = FALSE)
  return(data_clean)
}
