for (chosen_donor in ImmunoCleaner::data_combined_tidy %>%
                        dplyr::distinct(donor) %>%
                        dplyr::pull()) {

  umap_model <- ImmunoCleaner::data_combined_tidy %>%
    dplyr::filter(donor == chosen_donor) %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%
    dplyr::select(dplyr::matches("CD|HLA-DR")) %>%
    ImmunoCleaner:::clr_log2() %>%
    as.matrix() %>%
    uwot::umap(n_neighbors = 15,
               min_dist = 0.2,
               metric = "euclidean",
               ret_model = TRUE)

  uwot::save_uwot(umap_model,
                  file = stringr::str_c("umap_model_", chosen_donor),
                  verbose = FALSE)
  file.rename(from = stringr::str_c("umap_model_", chosen_donor),
              to = stringr::str_c("data/umap_model_", chosen_donor))

}
