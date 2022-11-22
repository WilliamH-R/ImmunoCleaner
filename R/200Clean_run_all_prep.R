#' Run all preparation functions
#'
#' `run_all_prep()` prepares the data frame it is given which is done through
#'     a series of functions. Firstly, the columns which aren't needed are removed.
#'     Then, the TCR-sequences are made tidy by splitting them and pivot longer.
#'     To keep track of their type - alpha or beta - a column is added specifying
#'     exactly that. The pMHC are made tidy and pivot longer as for the TCR-sequences.
#'     Further, the maximum UMI-count of all non-specific binders is added to
#'     enable an evaluation of the relevancy of a TCR-sequence immediately after.
#'     Lastly, a categorical identifier is added telling about the promiscuity
#'     of a TCR-sequence.
#'
#' The following functions are run:
#'  * `remove_unnecessary_columns()`
#'  * `find_non_promiscuous_split_TCR_sequences()`
#'  * `pivot_longer_TCR_sequences()`
#'  * `add_chain_ident_remove_prefix()`
#'  * `pivot_longer_pMHC()`
#'  * `tidy_allele_names()`
#'  * `add_max_non_specific_binder()`
#'  * `evaluate_binder()`
#'  * `add_TCR_combination_identifier()`
#'
#' @param .data A data frame which need preparation before modelling. Four such
#'     data frames are already present in this package:
#'     * `data_donor_one_raw`
#'     * `data_donor_two_raw`
#'     * `data_donor_three_raw`
#'     * `data_donor_four_raw`
#'
#' @return An object which is now prepared data frame, of the same type as `.data`.
#'  The output has the following differences:
#'  * Unnecessary columns are removed
#'  * TCR-sequences and pMHC are now tidy, and pivot longer
#'  * Several columns are added to aid modelling
#'
#' @family Preparation functions
#' @export
#'
#' @examples
#' # Simply supply the function with the name of a data frame:
#' run_all_prep(data_donor_one_raw)
#'
#' # Or by using the pipe from `magrittr`:
#' data_donor_one_raw %>%
#'     run_all_prep()
#'

run_all_prep <- function(.data) {

  data_clean <-
    .data %>%
    remove_unnecessary_columns() %>%
    find_non_promiscuous_split_TCR_sequences() %>%
    pivot_longer_TCR_sequences() %>%
    add_chain_ident_remove_prefix() %>%
    pivot_longer_pMHC() %>%
    tidy_pMHC_names() %>%
    add_max_non_specific_binder() %>%
    evaluate_binder() %>%
    add_TCR_combination_identifier() %>%
    check_if_HLA_match() %>%
    find_unique_binders()

  return(data_clean)
}
