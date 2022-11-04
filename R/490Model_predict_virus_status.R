#' Predict CMV and EBV status if missing
#'
#' `predict_virus_status()` takes a prepared data frame, `.data`, and try to
#'    predict the CMV and EBV status if it is missing. This is done...
#'
#' @inheritParams summarise_with_filter
#'
#' @return A string with the predicted missing CMV and EBV statuses.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_donor_four_tidy %>%
#'     predict_virus_status()
#'

predict_virus_status <- function(.data,
                                  identifier = barcode) {

.data %>%
  dplyr::select({{identifier}}, pMHC, peptide_source, is_binder) %>%
  dplyr::filter(is_binder == TRUE) %>%
  dplyr::group_by({{identifier}}) %>%
  dplyr::distinct(pMHC,
                  .keep_all = TRUE) %>%
  dplyr::ungroup() %>%
  dplyr::count(peptide_source,
               name = "count")
}
