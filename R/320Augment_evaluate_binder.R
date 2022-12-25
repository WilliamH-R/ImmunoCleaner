#' Calculate whether a binding is significant or not based on thresholds
#'
#' `evaluate_binder()` takes a set of thresholds and based on these evaluates
#'     whether a certain UMI-count is to be considered relevant or not. The
#'     UMI-count has to be larger than `UMI_count_min`, and multiple times
#'     larger than the largest non-specific binder.
#'
#' @param .data A cleaned data frame ready for augmentation.
#'
#' @param identifier Name of the column in the data set which identifies each
#'     experiment. Default is set to `barcode`.
#'
#' @param UMI_count_min An integer for the minimum number of UMI-counts to be
#'     observed before a binding can be assessed as relevant. The default
#'     is set to `10` by 10X Genomics.
#'
#' @param negative_control_UMI_count_min An integer which is multiplied with the
#'     maximum value for a non-specific binder. The product is used as
#'     another minimum requirement for the UMI-count to be relevant.
#'     Default is set to `5` by 10X Genomics.
#'
#' @return `.data` but with a new column which is a `boolean`. The `boolean` is
#'     `TRUE` if the binding between the pMHC and TCR-sequence is relevant.
#'     Otherwise returns `FALSE`.
#'
#' @family Preparation functions
#' @export
#'
#' @examples
#' # The function can be run without any arguments except `.data` as:
#' data_combined_tidy %>%
#'     evaluate_binder()
#'
#' # If supplied, the thresholds can be changed from the 10X Genomics standard as:
#' data_combined_tidy %>%
#'     evaluate_binder(UMI_count_min = 20,
#'                     negative_control_UMI_count_min = 10)
#'

evaluate_binder <- function(.data,
                            identifier = barcode,
                            UMI_count_min = 10,
                            negative_control_UMI_count_min = 5){

  data_aug <-
    .data %>%
    dplyr::group_by(donor,
                    {{identifier}}) %>%
    dplyr::mutate(is_binder = dplyr::case_when(UMI_count > UMI_count_min &
                                                 UMI_count > negative_control_UMI_count_min * max_negative_control_binder &
                                                 UMI_count == max(UMI_count,
                                                                  na.rm = TRUE) ~ TRUE,
                                               TRUE ~ FALSE),
                  is_binder = dplyr::case_when(sum(is_binder == TRUE) > 4 ~ FALSE,
                                               TRUE ~ is_binder)) %>%
    dplyr::ungroup()
  return(data_aug)
}
