data %>%
  dplyr::group_by(barcode) %>%
  dplyr::mutate(TCR_combination = dplyr::case_when(stringr::str_count(string = chain,
                                               pattern = "alpha") == 1 &
                                                 stringr::str_count(string = chain,
                                                 pattern = "beta") == 0 ~ 0,
                                               stringr::str_count(string = chain,
                                               pattern = "alpha") == 0 &
                                                 stringr::str_count(string = chain,
                                                 pattern = "beta") == 1 ~ 1,
                                               stringr::str_count(string = chain,
                                               pattern = "alpha") == 1 &
                                                 stringr::str_count(string = chain,
                                                 pattern = "beta") == 1 ~ 2,
                                     TRUE ~ 3)) %>%
  View()
