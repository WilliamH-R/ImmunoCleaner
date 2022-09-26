#' Title
#'
#' @inheritParams remove_unnecessary_columns
#'
#' @return Return a data frame with the "pMHC" split into three variables:
#' * "allele"
#' * "peptide"
#' * "peptide_source"
#' While keeping the original variable to use for modelling.
#' 
#' @family Cleaning functions
#' @noRd
#'
#'
tidy_allele_names <- function(.data,
                              names_into = c("allele", "peptide", "peptide_source"),
                              separator = "_"){ 
  data_clean <- 
    .data %>% 
    tidyr::separate(col = "pMHC",
                    into = names_into,
                    sep = separator,
                    extra = "merge",
                    remove = FALSE)
  return(data_clean)
}
