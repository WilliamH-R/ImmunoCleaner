#' Title
#'
#' @inheritParams summarise_binders
#'
#' @return Returns a table with all `barcode`s which has at least two `pMHC`
#'     marked as relevant.
#'
#' @family Modelling functions
#' @export
multiple_specific_binders <- function(.data,
                                      identifier = barcode) {

  specific_binders_count <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::distinct(pMHC) %>%
    dplyr::count() %>%
    dplyr::filter(n > 1)

  return(specific_binders_count)
}
