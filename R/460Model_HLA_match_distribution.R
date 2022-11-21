#' Predict allele typing if missing
#'
#' `HLA_match_distribution()` takes a prepared data frame, `.data`, and plot the
#'     distribution of whether or not the HLA-typing is a match. It is a match
#'     if `allele` for a relevant binder matches the noted HLA from the article.
#'
#' @inheritParams summarise_with_filter
#'
#' @return A bar plot showing the distribution between `TRUE` and `FALSE`.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_donor_four_tidy %>%
#'     HLA_match_distribution()
#'

HLA_match_distribution <- function(.data,
                                   identifier = barcode) {

  distribution_plot <-
    .data %>%
    dplyr::select({{identifier}}, donor, is_binder, pMHC, HLA_match) %>%
    dplyr::filter(is_binder == TRUE) %>%
    dplyr::group_by({{identifier}}) %>%
    dplyr::distinct(pMHC,
                    .keep_all = TRUE) %>%
    dplyr::ungroup() %>%

    ggplot2::ggplot(ggplot2::aes(x = HLA_match,
                                 fill = HLA_match)) +
    ggplot2::geom_bar() +
    ggplot2::labs(x = "HLA-match",
                  y = "Count",
                  title = "Distribution of whether HLA-typing matches") +
    ggplot2::theme(legend.position = "none") +
    ggplot2::facet_wrap(~ donor)

  return(distribution_plot)
}
