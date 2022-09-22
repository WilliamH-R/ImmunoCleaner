#' Title
#'
#' @param .data_aug An augmented data frame
#' @param distinct_by A variable in the dataframe with which the data set should
#'     be distinct by to avoid a bias towards cells with many observations.
#' @param summarise_by Which variable(s) a user whishes to get a summary of. To
#'     give a list of variables write `rlang::exprs(var1, var2)`
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
                                               peptide_source)) {
  data_model <-
    .data_aug %>%
    filter(is_binder == TRUE) %>%
    distinct({{distinct_by}},
             .keep_all = TRUE) %>%
    group_by(!!!summarise_by) %>%
    count()
  return(data_model)
}
