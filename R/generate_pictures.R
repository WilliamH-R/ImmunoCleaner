### Generate pictures from most functions
# Sadly have to supply name manually
data_combined_tidy %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 300)



data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_filter.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 300)



### Generate pictures from UMAP

for (protein in data_combined_tidy %>%
                    dplyr::select(dplyr::matches("CD|HLA.DR")) %>%
                    colnames() %>%
                    make.names()) {
  for (chosen_donor in TCRSequenceFunctions::data_combined_tidy %>%
        dplyr::distinct(donor) %>%
        dplyr::pull()) {

  data_combined_tidy %>%
    dplyr::filter(donor == chosen_donor) %>%
    umap_of_protein_expressions(color_by = protein)

  ggplot2::ggsave(stringr::str_c("umap_of_protein_expressions", protein, chosen_donor, ".png"),
                  path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                  dpi = 300)
  }
}
