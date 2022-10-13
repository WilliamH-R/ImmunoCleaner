#' Title
#'
#' @param data An augmented data frame ready for modelling.
#'
#' @param identifier A variable in the data frame with which the data set should
#'     be distinct by to avoid a bias towards experiments with many observations.
#'     Needs to be specified, even if set to default.
#'
#' @param ... Which variable(s) a user wishes to get a summary of. To
#'     give a list of variables write them individually.
#'
#'
#' @return The function returns a summarised count of whichever variable
#'     is provided in the argument `...` stratified on whichever
#'     variable is provided in the argument `distinct`.
#'
#' @family Modelling functions
#' @export
#'
summarise_with_filter <- function(.data,
                                  summarise_by = c("allele",
                                                   "peptide",
                                                   "peptide_source"),
                                  identifier = barcode) {

  data_model <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::group_by_at(dplyr::all_of(summarise_by)) %>%
    dplyr::count(name = "count")
  return(data_model)
}
