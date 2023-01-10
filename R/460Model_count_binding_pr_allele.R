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
#' data_combined_tidy %>%
#'     count_binding_pr_allele()
#'

count_binding_pr_allele <- function(.data,
                                    identifier = barcode) {

  scatter_plot <- .data %>%
  dplyr::select({{identifier}}, donor, pMHC,
                allele, is_binder, HLA_match) %>%
  dplyr::filter(is_binder == TRUE) %>%
  dplyr::distinct(donor,
                  {{identifier}},
                  pMHC,
                  .keep_all = TRUE) %>%

  ggplot2::ggplot(ggplot2::aes(x = forcats::fct_infreq(allele),
                               fill = HLA_match)) +
    ggplot2::geom_bar() +
    ggplot2::geom_text(ggplot2::aes(label = ggplot2::after_stat(count),
                                    color = HLA_match),
                       stat = "count",
                       vjust = -0.5) +
    ggplot2::facet_wrap(~ donor,
                        scales = "free") +
    ggplot2::labs(x = "Alleles",
                  y = "Count of occurences",
                  title = "Shows the count of occurences of alleles \nstratified by donor") +
    ggplot2::scale_fill_manual(name = "HLA-match",
                               values = c("TRUE" = "#00BA38",
                                          "UNKNOWN" = "#00BFC4",
                                          "FALSE" = "#F8766D")) +
    ggplot2::scale_colour_manual(values=c("TRUE"="#00BA38",
                                          "UNKNOWN"="#00BFC4",
                                          "FALSE"="#F8766D"),
                                 guide = "none") +
    ggplot2::scale_y_continuous(expand = ggplot2::expansion(mult = c(0, 0.1)))

  return(scatter_plot)
}
