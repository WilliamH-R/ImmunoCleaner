#' Title
#' 
#' @inheritParams summarise_binders
#' 
#' @param TCR_sequence_input A string which matches a TCR-sequence in the input
#'     data frame. Is then used for filtering, to only look at the frequencies
#'     of different alleles for this particular TCR-sequence.
#'     Default is arbitrarily set to `"CAARVRGFGNVLHC"`.
#'
#' @return A bar plot with the frequencies of all alleles for a particular 
#'     TCR-sequence.
#'
significant_binder_frequency <- function(.data) {
  frequency_histogram <-
    .data %>%
    dplyr::filter(is_binder == TRUE) %>%
    drop_na(non_promiscuous_pair) %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%
    dplyr::group_by(non_promiscuous_pair, pMHC) %>% 
    dplyr::count() %>%
    dplyr::group_by(non_promiscuous_pair) %>% 
    dplyr::mutate(n_frequency = n/sum(n)) %>% 
    dplyr::filter(n_frequency < 1) %>% 
    dplyr::distinct(non_promiscuous_pair)
    
return(frequency_histogram)
}



'ggplot2::ggplot(mapping = ggplot2::aes(x = pMHC,
                                                    y = ..prop..,
                                                    group = 1)) +
      ggplot2::geom_bar() +
      ggplot2::coord_flip() +
      ggplot2::labs(title = "Frequencies of alleles for a specific TCR-sequence",
                    x = "Allele",
                    y = "Frequency")'