#' Title
#'
#' @inheritParams summarise_binders
#'
#' @param chain_filter A string value to identify which chain `alpha` or
#'     `beta` used for the logo plot. Default is set to `alpha`.
#'
#' @param sequence_length An integer for the length of `TCR_sequence` desired
#'     for the logo plot.
#'
#' @return A logoplot of the specific chain of TCR-sequences specified by the
#'     argument `chain_filter`. To avoid duplicated cells, the input is made
#'     distinct with the argument `identifier`, with the default `barcode`.
#'
#' @family Modelling functions
#' @export
#'
logo_plot <- function(.data,
                      chain_filter = "alpha",
                      identifier = barcode,
                      sequence_length = 9) {

  data_model <-
    .data %>%
    dplyr::filter(is_binder == TRUE,
                  chain == chain_filter,
                  stringr::str_length(TCR_sequence) == sequence_length) %>%
    dplyr::distinct({{identifier}},
                    .keep_all = TRUE) %>%
    dplyr::pull(TCR_sequence) %>%
    ggseqlogo::ggseqlogo()

  return(data_model)
}
