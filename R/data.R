#' CD8+ T-cells of Healthy donor 1
#'
#' A dataset containing roughly 50 000 TCR alpha- and beta sequences for
#' Donor 1 along with different coding regions.
#'
#' @format A data frame with 46526 rows and 118 variables:
#' \describe{
#'   \item{barcode}{basepair sequence of peptide}
#'   \item{donor}{name of donor}
#'   \item{cell_clono_cdr3_aa}{amino acid sequence of CDR3 alpha and beta chains}
#'   \item{cell_clono_cdr3_nt}{nucleotide sequence of CDR3 alpha and beta chains}
#' }
#' @source \url{https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-1-1-standard-3-0-2}
"data_donor_one_raw"

#' CD8+ T-cells of Healthy donor 2
#'
#' A dataset containing roughly 80 000 TCR alpha- and beta sequences for
#' Donor 2 along with different coding regions.
#'
#' @format A data frame with 77854 rows and 118 variables:
#' \describe{
#'   \item{barcode}{basepair sequence of peptide}
#'   \item{donor}{name of donor}
#'   \item{cell_clono_cdr3_aa}{amino acid sequence of CDR3 alpha and beta chains}
#'   \item{cell_clono_cdr3_nt}{nucleotide sequence of CDR3 alpha and beta chains}
#' }
#' @source \url{https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-2-1-standard-3-0-2}
"data_donor_two_raw"

#' CD8+ T-cells of Healthy donor 3
#'
#' A dataset containing roughly 40 000 TCR alpha- and beta sequences for
#' Donor 3 along with different coding regions.
#'
#' @format A data frame with 37824 rows and 118 variables:
#' \describe{
#'   \item{barcode}{basepair sequence of peptide}
#'   \item{donor}{name of donor}
#'   \item{cell_clono_cdr3_aa}{amino acid sequence of CDR3 alpha and beta chains}
#'   \item{cell_clono_cdr3_nt}{nucleotide sequence of CDR3 alpha and beta chains}
#' }
#' @source \url{https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-3-1-standard-3-0-2}
"data_donor_three_raw"

#' CD8+ T-cells of Healthy donor 4
#'
#' A dataset containing roughly 30 000 TCR alpha- and beta sequences for
#' Donor 1 along with different coding regions.
#'
#' @format A data frame with 27308 rows and 118 variables:
#' \describe{
#'   \item{barcode}{basepair sequence of peptide}
#'   \item{donor}{name of donor}
#'   \item{cell_clono_cdr3_aa}{amino acid sequence of CDR3 alpha and beta chains}
#'   \item{cell_clono_cdr3_nt}{nucleotide sequence of CDR3 alpha and beta chains}
#' }
#' @source \url{https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-4-1-standard-3-0-2}
"data_donor_four_raw"

#' Prepared data from donor one
#'
#' The data frame contains a prepared version of the data from donor one
#'
#' @format A data frame with 500k rows and 27 columns
#'
#' @source Prepared data from `data_donor_one_raw`
"data_donor_one_tidy"

#' Prepared data from donor two
#'
#' The data frame contains a prepared version of the data from donor two
#'
#' @format A data frame with 800k rows and 27 columns
#'
#' @source Prepared data from `data_donor_two_raw`
"data_donor_two_tidy"

#' Prepared data from donor three
#'
#' The data frame contains a prepared version of the data from donor three
#'
#' @format A data frame with 580k rows and 27 columns
#'
#' @source Prepared data from `data_donor_three_raw`
"data_donor_three_tidy"

#' Prepared data from donor four
#'
#' The data frame contains a prepared version of the data from donor four
#'
#' @format A data frame with 190k rows and 27 columns
#'
#' @source Prepared data from `data_donor_four_raw`
"data_donor_four_tidy"

#' Mock data from donor one, top 1000 rows
#'
#' The data frame contains data from donor one, but only the top 1000 rows.
#' The purpose is to use this mock data in techinal report and vignette to speed
#' up computations.
#'
#' @format A data frame with 1k rows and 27 columns
#'
#' @source Prepared data from `data_donor_one_tidy`
"data_donor_one_mock"
