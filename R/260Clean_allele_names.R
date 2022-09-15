#' Title
#'
#' @inheritParams RunAllClean 
#'
#' @return Return a data frame with the "allele_info" split into three columns:
#' * "allele"
#' * "peptide"
#' * "peptide_source"
#'     While keeping the original column.
#' 
#' @family Cleaning functions
#'
#'
allele_names <- function(data){ 
  data_clean <- 
    data %>% 
    separate(col = "allele_info",
             into = c("allele", "peptide", "peptide_source"),
             sep = "_",
             remove = FALSE,
             extra = "merge")
  return(data_clean)
}
