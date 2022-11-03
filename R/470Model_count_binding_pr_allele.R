data_donor_four_tidy %>%
  dplyr::select(barcode, pMHC, allele, is_binder) %>%
  dplyr::filter(is_binder == TRUE) %>%
  dplyr::group_by(barcode) %>%
  dplyr::distinct(pMHC,
                  .keep_all = TRUE) %>%
  dplyr::ungroup() %>%
  dplyr::count(allele,
               name = "count") %>%

  ggplot2::ggplot(ggplot2::aes(x = reorder(allele, -count),
                               y = count)) +
  ggplot2::geom_point()
