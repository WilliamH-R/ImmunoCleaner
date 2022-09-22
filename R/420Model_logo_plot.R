#' Title
#'
#' @param .data_aug 
#' @param chain_filter 
#' @param distinct_by 
#' 
#' @importFrom ggseqlogo "ggseqlogo" 
#'
#' @return A logoplot of the specific chain of TCR-sequences specified by the
#'     argument `chain_filter`. To avoid duplicated cells, the input is made
#'     distinct with the argument `distinct_by`, with the default `barcode`.
#'
logo_plot <- function(.data_aug,
                      chain_filter = "alpha",
                      distinct_by = barcode) {

  data_model <-
    .data_aug %>%
    filter(is_binder == TRUE,
           chain == chain_filter,
           str_length(TCR_sequence) == 9) %>%
    distinct({{distinct_by}},
              .keep_all = TRUE) %>%
    pull(TCR_sequence) %>%
    ggseqlogo::ggseqlogo()

  return(data_model)
}

#The str_length should be removed when sequence alignment works
