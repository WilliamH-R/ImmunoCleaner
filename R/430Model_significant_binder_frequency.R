#' Title
#'
#' @return
#'
significant_binder_frequency <- function(.data_aug,
                                         TCR_sequence_input = "CAARVRGFGNVLHC") {
  frequency_histogram <-
    .data_aug %>%
    filter(is_binder == TRUE,
           TCR_sequence == TCR_sequence_input) %>%
    
    ggplot(mapping = aes(x = allele_info,
                         y = ..prop..,
                         group = 1)) +
      geom_bar() +
      coord_flip() +
      labs(title = "Frequencies of alleles for a specific TCR-sequence",
           x = "Allele",
           y = "Frequency")

return(frequency_histogram)
}
