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
  dplyr::select({{identifier}}, pMHC, allele, is_binder) %>%
  dplyr::filter(is_binder == TRUE) %>%
  dplyr::group_by({{identifier}}) %>%
  dplyr::distinct(pMHC,
                  .keep_all = TRUE) %>%
  dplyr::ungroup() %>%
  dplyr::count(allele,
               name = "count") %>%

  ggplot2::ggplot(ggplot2::aes(x = reorder(allele, -count),
                               y = count,
                               label = allele)) +
    ggplot2::geom_text(check_overlap = TRUE) +
    ggplot2::facet_wrap(~ stringr::str_match(allele,
                                             "[A|B|N]"),
                        scales = "free") +
    ggplot2::theme(axis.ticks.x = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_blank(),
                   axis.title = ggplot2::element_blank()) +
    ggplot2::coord_cartesian(clip = "off")

  return(scatter_plot)
}
