predict_allele_typing <- function(.data,
                                  identifier = barcode) {

  top_two_alleles <- .data %>%
    dplyr::select({{identifier}}, pMHC, allele, is_binder) %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::distinct(pMHC,
                    .keep_all = TRUE) %>%
    dplyr::ungroup() %>%
    dplyr::count(allele,
                 name = "count") %>%
    dplyr::filter(stringr::str_detect(allele,
                                      "B") == TRUE) %>%
    dplyr::arrange(desc(count)) %>%
    dplyr::slice(1:2) %>%
    dplyr::select(allele)

  if (stringr::str_detect(.data$donor[1],
                          "donor1")) {
    present_type <- "B3501"
    if (top_two_alleles[[1]][1] != present_type) {
      return(top_two_alleles[[1]][1])
    } else {
      return(top_two_alleles[[1]][2])
    }
  } else if (stringr::str_detect(.data$donor[1],
                                 "donor2")) {
    present_type <- "B0801"
    if (top_two_alleles[[1]][1] != present_type) {
      return(top_two_alleles[[1]][1])
    } else {
      return(top_two_alleles[[1]][2])
    }
  } else {
    return("You chose a data set where all HLA typings are known")
  }

}



