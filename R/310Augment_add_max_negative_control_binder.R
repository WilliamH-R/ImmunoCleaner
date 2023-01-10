#' Identify non-specific binder with highest UMI-count
#'
#' `add_max_negative_control_binder()` adds a new column `max_negative_control_binder` by
#'     checking if a pMHC is in a list of known non-specific pMHC. If yes, add
#'     the respective UMI-count in that new column, otherwise set to 0. If a
#'     TCR-sequence bound multiple non-specific binders, only choose the
#'     highest count.
#'
#' @param .data A data frame which has been cleaned, and is now ready for
#'     augmentation.
#'
#' @param identifier The column in the data set which identifies each
#'     experiment. Default is set to `barcode`.
#'
#' @return `.data` but with an added column. The column includes an integer for
#'     the maximum UMI-count out of all non-specific binders for each experiment.
#'
#' @family Preparation functions
#' @noRd
#'

add_max_negative_control_binder <- function(.data,
                                            identifier = barcode){
  # Tibble of the negative controls
  negative_control_binders_vector <- c("A0101_SLEGGGLGY_NC",
                                       "A0101_STEGGGLAY_NC",
                                       "A0201_ALIAPVHAV_NC",
                                       "A2402_AYSSAGASI_NC",
                                       "B0702_GPAESAAGL_NC",
                                       "NR(B0801)_AAKGRGAAL_NC")

  data_aug <-
    .data %>%
    dplyr::group_by(donor,
                    {{identifier}}) %>%
    dplyr::mutate(max_negative_control_binder = dplyr::case_when(is.element(pMHC,
                                                                            negative_control_binders_vector) == TRUE ~ UMI_count,
                                                             TRUE ~ 0),
                  max_negative_control_binder = max(max_negative_control_binder)) %>%
    dplyr::ungroup()

  return(data_aug)
}
