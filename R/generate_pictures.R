# ### Generate pictures from most functions
# # Sadly have to supply name manually
# data_combined_tidy %>%
#   alpha_beta_pair_distribution()
#
# ggplot2::ggsave("alpha_beta_pair_distribution.png",
#                 path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
#                 dpi = 300)
#
#
#
# data_combined_tidy %>%
#   dplyr::filter(is_binder == TRUE) %>%
#   alpha_beta_pair_distribution()
#
# ggplot2::ggsave("alpha_beta_pair_distribution_filter.png",
#                 path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
#                 dpi = 300)
#
#
#
# ### Generate pictures from UMAP
#
# for (protein in c("CD279_PD.1")) {
#
#   data_combined_tidy %>%
#     dplyr::filter(donor == "donor1") %>%
#     umap_of_protein_expressions(color_by = protein)
#
#   ggplot2::ggsave(stringr::str_c("umap_of_protein_expressions", protein, ".png"),
#                   path = "C:\\Users\\Willi\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
#                   dpi = 300)
# }
