#' Title
#'
#' @param .data_aug 
#' @param distinct_by 
#' @param summarise_by 
#' 
#' @importFrom rlang "exprs" 
#'
#' @return The function returns a summarised count of whichever variable
#'     is provided in the argument `summarise_by` stratified on whichever
#'     variable is provided is provided in the argument `distinct`.
#'
summarise_binders <- function(.data_aug,
                              distinct_by = barcode,
                              summarise_by = rlang::exprs(allele,
                                               peptide,
                                               peptide_source)){ 
  
  data_model <-
    .data_aug %>%
    filter(is_binder == TRUE) %>%
    distinct({{distinct_by}},
             .keep_all = TRUE) %>%
    group_by(!!!summarise_by) %>%
    count()
  return(data_model)
}
