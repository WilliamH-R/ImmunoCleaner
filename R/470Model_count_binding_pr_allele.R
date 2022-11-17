#' Scatter plot showing relevant binder count for each allele type
#'
#' `count_binding_pr_allele()` takes a prepared data frame, `.data`, and
#'     count the number of relevant binders that exist for each allele present.
#'     This is done by making pMHC unique after grouping on `identifier` and then
#'     counting.
#'
#' @inheritParams summarise_with_filter
#'
#' @return A scatter plot showing the count of relevant binders for each allele.
#'
#' @family Modelling functions
#' @export
#'
#' @examples
#' # A prepared data frame is simply piped through the function:
#' data_donor_four_tidy %>%
#'     count_binding_pr_allele()
#'

count_binding_pr_allele <- function(.data,
                                    identifier = barcode) {

  scatter_plot <- .data %>%
  dplyr::select({{identifier}}, donor, pMHC, allele, is_binder, HLA_match) %>%
  dplyr::filter(is_binder == TRUE) %>%
  dplyr::group_by({{identifier}}) %>%
  dplyr::distinct(pMHC,
                  .keep_all = TRUE) %>%
  dplyr::ungroup() %>%

  ggplot2::ggplot(ggplot2::aes(x = forcats::fct_infreq(allele),
                               fill = HLA_match)) +
    ggplot2::geom_bar() +
    ggplot2::facet_wrap(~ donor) +
    ggplot2::theme(axis.title = ggplot2::element_blank()) +
    ggplot2::scale_fill_discrete(name = "HLA-match")

  return(scatter_plot)
}
