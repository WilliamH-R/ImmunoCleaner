#' Prepared data from all four donors
#'
#' The data frame contains a prepared version of the data from all donors.
#'     Raw data files were combined and piped through all cleaning and
#'     augmenting functions.
#'
#' @format A data frame with 2.1 mill rows and 28 columns
#'
#' @source Prepared data from all four raw data files:
#' \itemize{
#'     \item `data_donor_one_raw`. raw data file from donor one from \url{https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor1/vdj_v1_hs_aggregated_donor1_binarized_matrix.csv}
#'     \item `data_donor_two_raw`. raw data file from donor two from \url{https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor2/vdj_v1_hs_aggregated_donor2_binarized_matrix.csv}
#'     \item `data_donor_three_raw`. raw data file from donor three from \url{https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor3/vdj_v1_hs_aggregated_donor3_binarized_matrix.csv}
#'     \item `data_donor_four_raw`. raw data file from donor four from \url{https://cf.10xgenomics.com/samples/cell-vdj/3.0.2/vdj_v1_hs_aggregated_donor4/vdj_v1_hs_aggregated_donor4_binarized_matrix.csv}
#'}
#'
"data_combined_tidy"

#' Auxiliary data set with alleles and disease status
#'
#' The data frame contains information of which allele group and HLA protein
#'     each donor has along with information of disease status.
#'
#' @format A data frame with 4 rows and 7 columns
#'
#' @source \url{https://www.10xgenomics.com/resources/document-library/a14cde}
"aux_alleles_status_each_donor"
