data %>%
  dplyr::filter(is_binder == TRUE) %>%
  tidyr::drop_na(non_promiscuous_pair) %>%
  dplyr::distinct(barcode,
                  .keep_all = TRUE) %>%
  dplyr::group_by(non_promiscuous_pair, pMHC) %>%
  dplyr::count()
%>%
  dplyr::group_by(non_promiscuous_pair) %>%
  dplyr::mutate(n_frequency = n/sum(n)) %>%
  dplyr::filter(n_frequency < 1)
