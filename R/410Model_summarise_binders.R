summarise_binders <- function(.data_aug,
                              distinct_by = barcode,
                              identifier = barcode,
                              summarise_by = rlang::exprs(allele,
                                               peptide,
                                               peptide_source)){ 
  
  data_model <-
    .data_aug %>%
    filter(is_binder == TRUE) %>%
    distinct({{distinct_by}},
             .keep_all = TRUE) %>%
    group_by(!!!summarise_by) %>%
    count()
  return(data_model)
}
