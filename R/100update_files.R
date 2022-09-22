#' Title
#'
#' @import tidyverse
#' @importFrom magrittr "%>%"
#'
update_files <- function() {
  list.files("data-raw", full.names = TRUE) %>%
  stringr::str_extract(".+\\.R") %>%
  na.omit() %>%
  purrr::walk(source)
}