clr_log2 <- function(x) {
  W <- compositions::oneOrDataset(x)
  nmv <- compositions::is.NMV(W)
  LOG <- unclass(log(ifelse(nmv, W, 1), base = 2))
  erg <- ifelse(nmv, LOG - compositions:::gsi.rsum(LOG)/compositions:::gsi.rsum(nmv), 0)
  compositions::rmult(compositions:::gsi.simshape(erg, x), orig = x)
}


prep_data_for_summarise <- function (.data_to_prep,
                                     identifier = barcode,
                                     summarise_by = summarise_by) {
  data_prep <- .data_to_prep %>%
    dplyr::select({{identifier}}, donor, pMHC, allele,
                  peptide, peptide_source, is_binder) %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::distinct({{identifier}},
                    pMHC,
                    .keep_all = TRUE) %>%
    dplyr::group_by_at(summarise_by) %>%
    dplyr::count(donor,
                 name = "count") %>%
    dplyr::ungroup() %>%
    dplyr::arrange(donor) %>%
    tidyr::pivot_wider(names_from = donor,
                       values_from = count)
  return(data_prep)
}

prep_data_percentage_kept <- function(.data_to_prep,
                                      identifier = barcode,
                                      name) {
  data_prep <- .data_to_prep %>%
    dplyr::select(is_binder,
                  {{identifier}},
                  donor,
                  pMHC) %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::distinct(donor,
                    {{identifier}},
                    pMHC,
                    .keep_all = TRUE) %>%
    dplyr::count(donor,
                 name = name)

  return(data_prep)
}
