## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ImmunoCleaner)
library(gt)

## -----------------------------------------------------------------------------
data_baseline <- data_combined_tidy %>% 
  dplyr::filter(is_binder == TRUE)

## -----------------------------------------------------------------------------
data_strict <- data_combined_tidy %>% 
  dplyr::filter(HLA_match == "TRUE") %>% 
  evaluate_binder(UMI_count_min = 40) %>% 
  dplyr::filter(is_binder == TRUE)

## ----eval=FALSE---------------------------------------------------------------
#  data_strict %>%
#    filter(HLA_match == "TRUE") %>%
#    percentage_rows_kept

## ----echo=FALSE---------------------------------------------------------------
data_strict %>%
  percentage_rows_kept() %>% 
  gt() %>%
  cols_label(donor = gt::md("**donor**"),
             percentage_left = gt::md("**percentage_left**")) %>% 
  tab_options(
    heading.border.bottom.width = 10,
    table.width = pct(80)
  ) %>% 
  cols_align(
    align = "left",
    columns = everything()
  ) %>%
  fmt_number(columns = percentage_left,
             decimals = 2)

## -----------------------------------------------------------------------------
data_baseline %>% 
  count_binding_pr_allele()

## -----------------------------------------------------------------------------
data_baseline %>% 
  relevant_binders_plot()

## -----------------------------------------------------------------------------
data_strict %>% 
  relevant_binders_plot()

