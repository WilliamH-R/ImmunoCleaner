### Generate pictures from most functions
## Sadly have to supply name manually

# Mild filter
data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_mild.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 300)


# Strict filter
data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_strict.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 300)


### Generate pictures from tables
## percentage_rows_kept
# width = 218
# height = 224
# Mild
data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  percentage_rows_kept() %>%
  gt::gt() %>%
  gt::cols_label(donor = md("**donor**"),
                 percentage_left = md("**percentage_left**"))

# Strict
data_combined_tidy %>%
  evaluate_binder(UMI_count = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  percentage_rows_kept() %>%
  gt::gt() %>%
  gt::cols_label(donor = md("**donor**"),
                 percentage_left = md("**percentage_left**")) %>%
  gt::fmt_number(columns = percentage_left,
                 decimals = 2)

## summarise_with_filter
# width =
# height =
# Mild
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  dplyr::filter(is_binder == TRUE) %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = md("**allele**"),
                 donor1_old = md("**donor1_old**"),
                 donor2_old = md("**donor2_old**"),
                 donor3_old = md("**donor3_old**"),
                 donor4_old = md("**donor4_old**"),
                 donor1_new = md("**donor1_new**"),
                 donor2_new = md("**donor2_new**"),
                 donor3_new = md("**donor3_new**"),
                 donor4_new = md("**donor4_new**")
  )

# Strict
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  evaluate_binder(UMI_count = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = md("**allele**"),
                donor1_old = md("**donor1_old**"),
                #donor2_old = md("**donor2_old**"),
                #donor3_old = md("**donor3_old**"),
                #donor4_old = md("**donor4_old**"),
                donor1_new = md("**donor1_new**"),
                #donor2_new = md("**donor2_new**"),
                #donor3_new = md("**donor3_new**"),
                #donor4_new = md("**donor4_new**")
                )





data_combined_tidy %>%
  dplyr::group_by(is_binder) %>%
  dplyr::slice_head(n = 3) %>%
  dplyr::select(pMHC,
                UMI_count,
                max_negative_control_binder,
                is_binder) %>%
  gt(rowname_col = "pMHC") %>%
  cols_label(
    UMI_count = md("**UMI_count**"),
    max_negative_control_binder = md("**max_negative_control_binder**"),
    is_binder = md("**is_binder**")
  ) %>%
  tab_style(
    style = cell_text(align = "center"),
    locations = cells_body(
      columns = everything()
    )
  )


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
