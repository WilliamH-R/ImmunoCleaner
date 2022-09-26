#' Title
#'
#' @param data An augmented data frame ready for modelling.
#' 
#' @param distinct_by A variable in the dataframe with which the data set should
#'     be distinct by to avoid a bias towards experiments with many observations.
#'     
#' @param summarise_by Which variable(s) a user whishes to get a summary of. To
#'     give a list of variables write `rlang::exprs(var1, var2)`
#'
#'
#' @return The function returns a summarised count of whichever variable
#'     is provided in the argument `summarise_by` stratified on whichever
#'     variable is provided is provided in the argument `distinct`.
#'     
#' @export
#'
summarise_binders <- function(.data,
                              ...,
                              distinct_by = barcode) {
  data_model <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::distinct({{distinct_by}},
                    .keep_all = TRUE) %>%
    dplyr::group_by(...) %>%
    dplyr::count()
  return(data_model)
}
