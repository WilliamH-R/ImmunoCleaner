umap_models <- vector(mode = "list",
                      length = TCRSequenceFunctions::data_combined_tidy %>%
                        dplyr::pull(donor) %>%
                        unique() %>%
                        length())

for (chosen_donor in TCRSequenceFunctions::data_combined_tidy %>%
                        dplyr::pull(donor) %>%
                        unique()) {

  umap_model <- TCRSequenceFunctions::data_combined_tidy %>%
    dplyr::filter(donor == chosen_donor) %>%
    dplyr::distinct(barcode,
                    .keep_all = TRUE) %>%
    dplyr::select(dplyr::matches("CD|HLA-DR")) %>%
    dplyr::slice_sample(n = 100) %>%
    compositions::clr() %>%
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
