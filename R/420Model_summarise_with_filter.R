#' Count of relevant binders stratified on user input
#'
#' `summarise_with_filter()` takes a prepared data frame as input, and count
#'    the number of pMHC which are evaluated as relevant by `?evaluate_binder`.
#'    The counting is grouped by columns provided by the user through the argument
#'    `...`.
#'
#' @param .data An prepared data frame ready for modelling.
#'
#' @param summarise_by The column(s) a user wishes to get a summary of. Provide
#'     as a string or vector of strings. Default is the columns prepared from
#'     pMHC.
#'
#' @param identifier A variable in the data frame with which the data set should
#'     be distinct by to avoid a bias towards experiments with many observations.
#'
#' @return A table with a count of relevant binders stratified on `summarise_by`.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame needs to be provided. Can either be done by piping
#' # a tidy data frame through the function:
#' data_combined_tidy %>%
#'     summarise_with_filter()
#'
#'
#' # The stratification can be done for one or several columns:
#' data_combined_tidy %>%
#'     summarise_with_filter(summarise_by = "allele")
#'
#' data_combined_tidy %>%
#'     summarise_with_filter(summarise_by = c("allele",
#'                                            "peptide_source"))
#'

summarise_with_filter <- function(.data,
                                  summarise_by = c("allele",
                                                   "peptide",
                                                   "peptide_source"),
                                  identifier = barcode) {

  prep_data_for_summarise <- function (.data_to_prep) {
    data_prep <- .data_to_prep %>%
      dplyr::select(barcode, donor, pMHC, allele,
                    peptide, peptide_source, is_binder) %>%
      dplyr::filter(is_binder == TRUE) %>%
      dplyr::distinct({{identifier}},
                      pMHC,
                      .keep_all = TRUE) %>%
      dplyr::group_by_at(summarise_by) %>%
      dplyr::count(donor,
                   name = "count") %>%
      dplyr::ungroup() %>%
      dplyr::arrange(donor) %>%
      tidyr::pivot_wider(names_from = donor,
                         values_from = count)
    return(data_prep)
  }

  donors_present <- .data %>%
    dplyr::distinct(donor) %>%
    dplyr::pull()

  data_old <- TCRSequenceFunctions::data_combined_tidy %>%
    dplyr::filter(donor %in% donors_present) %>%
    prep_data_for_summarise()

  data_new  <- .data %>%
    prep_data_for_summarise()


  data_model <-
    dplyr::full_join(data_old,
                     data_new,
                     by = summarise_by,
                     suffix = c("_old",
                                "_new")
                     ) %>%
    dplyr::arrange(desc(dplyr::across(starts_with("donor"))))

  return(data_model)
}
