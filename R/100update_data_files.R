#' Title
#'
update_data_files <- function() {
  list.files("data-raw", full.names = TRUE) %>%
  purrr::walk(source)
}
