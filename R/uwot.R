data_combined_tidy_temp <- data_combined_tidy %>%
  dplyr::filter(donor == "donor4") %>%
  dplyr::distinct(barcode, .keep_all = TRUE) %>%
  dplyr::select(dplyr::matches("CD|Ig|HLA")) %>%
  dplyr::slice_sample(prop = 1)


umap_model <- data_combined_tidy_temp %>%
                dplyr::select(dplyr::matches("CD|Ig|HLA-DR")) %>%
                uwot::umap(n_neighbors = 15,
                           min_dist = 0.2,
                           metric = "euclidean")


dplyr::bind_cols(umap_model %>% tibble::as_tibble(),
                 data_combined_tidy_temp) %>%
  tidyr::pivot_longer(cols = dplyr::matches("CD|Ig|HLA-DR"),
                      names_to = "color",
                      values_to = "expression") %>%
  ggplot2::ggplot(ggplot2::aes(x = V1,
                               y = V2,
                               color = expression)) +
  ggplot2::geom_point() +
  ggplot2::scale_color_continuous(type = "viridis") +
  ggplot2::facet_wrap(~ color)


dplyr::bind_cols(umap_model %>% tibble::as_tibble(),
                 data_combined_tidy_temp) %>%
  ggplot2::ggplot(ggplot2::aes(x = V1,
                               y = V2,
                               color = CD45RA)) +
  ggplot2::geom_point() +
  ggplot2::scale_color_continuous(type = "viridis")
