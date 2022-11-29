#' Prepared data from all four donors
#'
#' The data frame contains a prepared version of the data from all donors.
#'     Raw data files were combined and piped through all cleaning and
#'     augmenting functions.
#'
#' @format ## 'data_combined_tidy'
#' A data frame with 2.1 mill rows and 28 columns:
#' \describe{
#'     \item{barcode}{`character`. Unique identifier for each cell in Single Cell Experiment}
#'     \item{TCR_sequence}{`character`. Amino acid sequence of either the alpha or beta chain. Specified in `chain`}
#'     \item{TCR_combination}{`factor`. Category to note types of `chain` belonging to the `barcode`}
#'     \item{donor}{`character`. Specifies which `donor` the `barcode` originates from}
#'     \item{chain}{`character`. Specifies the type of `chain`}
#'     \item{CD3}{`numeric`. Expression level of protein}
#'     \item{CD19}{`numeric`. Expression level of protein}
#'     \item{CD45RA}{`numeric`. Expression level of protein}
#'     \item{CD4}{`numeric`. Expression level of protein}
#'     \item{CD8a}{`numeric`. Expression level of protein}
#'     \item{CD14}{`numeric`. Expression level of protein}
#'     \item{CD45RO}{`numeric`. Expression level of protein}
#'     \item{CD279_PD-1}{`numeric`. Expression level of protein}
#'     \item{IgG1}{`numeric`. Expression level of protein}
#'     \item{IgG2a}{`numeric`. Expression level of protein}
#'     \item{IgG2b}{`numeric`. Expression level of protein}
#'     \item{CD127}{`numeric`. Expression level of protein}
#'     \item{CD197_CCR7}{`numeric`. Expression level of protein}
#'     \item{HLA-DR}{`numeric`. Expression level of protein}
#'     \item{non_promiscuous_pair}{`character`. Contains the combined alpha:beta sequence, if exactly one of each exist for a `barcode`. Otherwise `NA`}
#'     \item{pMHC}{`character`. The pMHC which the `TCR_sequence` binds to}
#'     \item{allele}{`character`. The specific `allele` in the `pMHC`}
#'     \item{peptide}{`character`. The specific `peptide` in the `pMHC`}
#'     \item{peptide_source}{`character`. The origin of the `peptide` in the `pMHC`}
#'     \item{UMI_count}{`numeric`. The number of transcripts observed. Used to score how trustworthy an interaction is. Higher number means more trustworthy}
#'     \item{max_non_specific_binder}{`numeric`. The `UMI_count` of the highest scoring non-specific binder to the `barcode`. If no binder, `0`}
#'     \item{is_binder}{`boolean`. If the `UMI_count` complies with a set of thresholds, the value is `TRUE`, otherwise `FALSE`. When `TRUE` the interaction between `TCR_sequence` and `pMHC` is relevant}
#'     \item{HLA_match}{`character`. Check of whether `allele` match the HLA-typing belonging to `donor`, in that case `TRUE`. If typing for `donor` is missing, `UNKNOWN`. Otherwise `FALSE`}
#'     \item{unique_binder}{`boolean`. Check if the binding between `TCR_sequence` and `pMHC` is only observed once, then `TRUE`. Otherwise, `FALSE`}
#' }
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
