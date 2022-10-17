#' Title
#'
#'
#' @param .data A cleaned data frame ready for augmentation.
#'
#' @param identifier The column in the data set which identifies each
#'     experiment. Default is set to `barcode`.
#'
#' @param threshold An integer for the minimum number of UMI counts to be
#'     observed before a binding can be assessed as relevant. The default
#'     is set to `10`.
#'
#' @param non_specific_threshold An integer which is multiplied with the
#'     maximum value for a non-specific binder. The product is used as
#'     another minimum requirement for the UMI-count the be relevant.
#'     Default is set to `5`.
#'
#' @return The same data frame, but with a new column which is a `boolean`.
#'     The `boolean` is `TRUE` if the binding between the peptide and
#'     TCR-sequence is relevant. Otherwise returns `FALSE`.
#'
#' @family Augmenting functions
#' @export
#'
evaluate_binder <- function(.data,
                            identifier = barcode,
                            threshold = 10,
                            non_specific_threshold = 5){

  data_aug <-
    .data %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::mutate(is_binder = dplyr::case_when(UMI_count > threshold &
                                                 UMI_count > non_specific_threshold * max_non_specific_binder &
                                                 UMI_count == max(UMI_count,
                                                                  na.rm = TRUE) ~ TRUE,
                                               TRUE ~ FALSE),
                  is_binder = dplyr::case_when(sum(is_binder == TRUE) > 4 ~ FALSE,
                                               TRUE ~ is_binder)) %>%
    dplyr::ungroup()
  return(data_aug)
}
