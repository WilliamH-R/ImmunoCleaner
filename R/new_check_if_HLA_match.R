lookup <- tibble::tribble(~donor, ~allele, ~HLA_match,
                          "donor1", "A0201", "TRUE",
                          "donor1", "A1101", "TRUE",
                          "donor1", "B3501", "TRUE",
                          "donor2", "A0201", "TRUE",
                          "donor2", "A0101", "TRUE",
                          "donor2", "B0801", "TRUE",
                          "donor3", "A2402", "TRUE",
                          "donor3", "A2902", "TRUE",
                          "donor3", "B3502", "TRUE",
                          "donor3", "B4403", "TRUE",
                          "donor4", "A0301", "TRUE",
                          "donor4", "B0702", "TRUE",
                          "donor4", "B5701", "TRUE",
)

alleles_present <- data_combined_tidy %>%
  dplyr::distinct(donor, allele) %>%
  dplyr::mutate(HLA_gene_type = stringr::str_extract(allele, "[A|B]"))

HLA_match <- alleles_present %>%
  dplyr::left_join(lookup,
                   by = c("donor", "allele")) %>%
  dplyr::add_count(donor, HLA_gene_type) %>%
  dplyr::mutate(HLA_match = dplyr::case_when())


data_aug <- data_combined_tidy %>%
  dplyr::select(donor == "donor4")
  dplyr::left_join(lookup,
                   by = c("donor", "allele")) %>%
  dplyr::mutate(HLA_match = dplyr::case_when(is.na(HLA_match) &
                                               (donor == "donor1" | donor == "donor2") &
                                               stringr::str_detect(string = allele,
                                                                   pattern = "^B") ~ "UNKNOWN",
                                             is.na(HLA_match) ~ "FALSE",
                                             TRUE ~ HLA_match))
