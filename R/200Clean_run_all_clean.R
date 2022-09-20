#' Run all other clean-functions
#'
#' `RunAllClean()` cleans the data structure it is given by removing
#' incomplete/wrong TRA:TRB sequence pairs and removing all the binding assessments.
#' The following functions are run:
#'  * 210Clean_EnsureOneAlphaBetaPair.R
#'  * 220Clean_SplitTCRSequences.R
#'  * 230Clean_RemovePrefix.R
#'  * 240Clean_RemoveBinders.R
#'  
#' @param data is a data structure which need cleaning
#'
#' @return Return a cleaned data structure, of the same type as the input.
#'  The output has the following differences:
#'  * Observations are removed if they do not have a TRA:TRB pair
#'  * Two new columns are added, one for TRA and one for TRB
#'  * The binding assessments are removed
#'  
#' @family Cleaning functions
#'  
#'
#' @examples
#' RunAllClean(vdj_v1_hs_aggregated_donor1_binarized_matrix.rda)
run_all_clean <- function(data){ 
  data_clean <- 
    data %>% 
    remove_unnecessary_columns() %>% 
    split_TCR_sequences() %>% 
    pivot_longer_TCR_sequences() %>% 
    add_chain_ident_remove_prefix() %>%
    pivot_longer_allele() %>% 
    add_max_non_specific_binder() %>% 
    tidy_allele_names() %>%
  return(data_clean)
}
