### Generate pictures from tables
## percentage_rows_kept
# width = 218
# height = 224
# Mild
data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  percentage_rows_kept() %>%
  gt::gt() %>%
  gt::cols_label(donor = gt::md("**donor**"),
                 percentage_left = gt::md("**percentage_left**"))

# Strict
data_combined_tidy %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  percentage_rows_kept() %>%
  gt::gt() %>%
  gt::cols_label(donor = gt::md("**donor**"),
                 percentage_left = gt::md("**percentage_left**")) %>%
  gt::fmt_number(columns = percentage_left,
                 decimals = 2)

## summarise_with_filter
# width = 301, 907
# height = 339, 430

# Mild
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  dplyr::filter(is_binder == TRUE) %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = gt::md("**allele**"),
                 donor1_old = gt::md("**donor1_old**"),
                 donor1_new = gt::md("**donor1_new**")
  )

data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = gt::md("**allele**"),
                 donor1_old = gt::md("**donor1_old**"),
                 donor2_old = gt::md("**donor2_old**"),
                 donor3_old = gt::md("**donor3_old**"),
                 donor4_old = gt::md("**donor4_old**"),
                 donor1_new = gt::md("**donor1_new**"),
                 donor2_new = gt::md("**donor2_new**"),
                 donor3_new = gt::md("**donor3_new**"),
                 donor4_new = gt::md("**donor4_new**")
  )

# Strict
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = gt::md("**allele**"),
                 donor1_old = gt::md("**donor1_old**"),
                 donor1_new = gt::md("**donor1_new**"))

data_combined_tidy %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  summarise_with_filter(summarise_by = c("allele")) %>%
  gt::gt() %>%
  gt::cols_label(allele = gt::md("**allele**"),
                 donor1_old = gt::md("**donor1_old**"),
                 donor2_old = gt::md("**donor2_old**"),
                 donor3_old = gt::md("**donor3_old**"),
                 donor4_old = gt::md("**donor4_old**"),
                 donor1_new = gt::md("**donor1_new**"),
                 donor2_new = gt::md("**donor2_new**"),
                 donor3_new = gt::md("**donor3_new**"),
                 donor4_new = gt::md("**donor4_new**")
  )


### Generate pictures from most functions

## boxplot_protein_expressions
for (protein in data_combined_tidy %>%
     dplyr::select(dplyr::matches("CD|HLA.DR")) %>%
     colnames() %>%
     make.names()) {
  # Mild filter
  data_combined_tidy %>%
    dplyr::filter(is_binder == TRUE) %>%
    boxplot_protein_expressions(plot_protein = protein)

  ggplot2::ggsave(stringr::str_c("boxplot_protein_expressions_mild", protein, ".png"),
                  path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                  dpi = 400)


  # Strict filter
  data_combined_tidy %>%
    dplyr::filter(is_binder == TRUE,
                  HLA_match == "TRUE") %>%
    boxplot_protein_expressions(plot_protein = protein)

  ggplot2::ggsave(stringr::str_c("boxplot_protein_expressions_strict", protein, ".png"),
                  path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                  dpi = 400)
}

##  alpha_beta_distinctiveness
# Mild filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_distinctiveness()

ggplot2::ggsave("alpha_beta_distinctiveness_mild_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_distinctiveness()

ggplot2::ggsave("alpha_beta_distinctiveness_mild_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)


# Strict filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  evaluate_binder(UMI_count_min = 40,
                  negative_control_UMI_count_min = 30) %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_distinctiveness()

ggplot2::ggsave("alpha_beta_distinctiveness_strict_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

data_combined_tidy %>%
  evaluate_binder(UMI_count_min = 40,
                  negative_control_UMI_count_min = 30) %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_distinctiveness()

ggplot2::ggsave("alpha_beta_distinctiveness_strict_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

##  alpha_beta_pair_distribution
# Mild filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_mild_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_mild_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)


# Strict filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_strict_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

data_combined_tidy %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  alpha_beta_pair_distribution()

ggplot2::ggsave("alpha_beta_pair_distribution_strict_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5, width = 7)

##  count_binding_pr_allele
# Mild filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  dplyr::filter(is_binder == TRUE) %>%
  count_binding_pr_allele()

ggplot2::ggsave("count_binding_pr_allele_mild_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5)

data_combined_tidy %>%
  dplyr::filter(is_binder == TRUE) %>%
  count_binding_pr_allele

ggplot2::ggsave("count_binding_pr_allele_mild_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5)


# Strict filter
data_combined_tidy %>%
  dplyr::filter(donor == "donor1") %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  count_binding_pr_allele()

ggplot2::ggsave("count_binding_pr_allele_strict_donor_one.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5)

data_combined_tidy %>%
  evaluate_binder(UMI_count_min = 40) %>%
  dplyr::filter(is_binder == TRUE,
                HLA_match == "TRUE") %>%
  count_binding_pr_allele()

ggplot2::ggsave("count_binding_pr_allele_strict_all.png",
                path = "C:\\Users\\William\\OneDrive - Danmarks Tekniske Universitet\\Bachelor\\Pictures",
                dpi = 400, scale = 0.5)



### Generate pictures from UMAP
# Fjern inner loop for at få alle donors i samme plot

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
                  dpi = 400)
  }
}
