#' Wrapper for updating data files
#'
#' `update_data_files()` runs all files in `"data-raw"` which both re-downloads
#'     the raw data files and run them through the wrapper `run_all_prep()` to
#'     produce `data_combined_tidy` again. The umap-model will also be
#'     re-calculated to match the newly updated data. The final script is a
#'     static file containing the HLA-types and virus statuses of the donors.
#'     The following scripts are run:
#'  * `01data_download_raw.R`
#'  * `02data_combined_tidy.R`
#'  * `03data_generate_umap_models.R`
#'  * `aux_alleles_status_each_dono.R`
#'
#'  @noRd
#'
update_data_files <- function() {
  list.files("data-raw", full.names = TRUE) %>%
  purrr::walk(source)
}
