#' Run all other clean-functions
#'
#' RunAllClean() cleans the data structure it is given by removing
#' incomplete/wrong TRA:TRB pairs and removing all the binding assessments.
#' The following functions are run:
#'  * 210Clean_EnsureOneAlphaBetaPair.R
#'  *220Clean_SplitTCRSequences.R
#'  * 230Clean_RemovePrefix.R
#'  *240Clean_RemoveBinders.R
#'  
#' \itemize{
#'   \item ´210Clean_EnsureOneAlphaBetaPair.R´
#'   \item ´220Clean_SplitTCRSequences.R´
#'   \item ´230Clean_RemovePrefix.R´
#'   \item ´240Clean_RemoveBinders.R´
#'   }
#'   
#'
#' @param data is a data structure which need cleaning according to what
#'     the other functions do.
#'
#' @return a cleaned data structure
#' @export
#'
#' @examples
#' RunAllClean(vdj_v1_hs_aggregated_donor1_binarized_matrix.rda)
RunAllClean <- function(data){ 
  data %>% 
    EnsureOneAlphaBetaPair() %>% 
    SplitTCRSequences() %>% 
    RemovePrefix() %>% 
    RemoveBinders()
}