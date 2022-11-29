# TCRSequencesFunctions

## Overview

This package contains a series of functions to tidy and model data sets pertaining to Single Cell Immune Profiling. These data sets are also included in the package, and was made publicly available by 10x Genomics. (source: [10x Genomics](https://www.10xgenomics.com/resources/datasets?query=&page=1&configure%5Bfacets%5D%5B0%5D=chemistryVersionAndThroughput&configure%5Bfacets%5D%5B1%5D=pipeline.version&configure%5BhitsPerPage%5D=500&configure%5BmaxValuesPerFacet%5D=1000&menu%5Bproducts.name%5D=Single%20Cell%20Immune%20Profiling)).

The included raw data sets are:

* `data_donor_one_raw`: Data from donor one. Each row represent a cell from the donor. Each column contains either a TCR-sequence or an UMI-count for interactions between the antibodies of the cell and a pMHC. Lastly, columns are included to evaluate whether an interaction is relevant or not. The value is a boolean. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-1-1-standard-3-0-2)

* `data_donor_two_raw`: Data from donor two. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-2-1-standard-3-0-2)

* `data_donor_three_raw`: Data from donor three. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-3-1-standard-3-0-2)

* `data_donor_four_raw`: Data from donor four. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-4-1-standard-3-0-2)

For each of the raw data sets, a tidy version exist to avoid the need of always running the wrapper function `run_all_prep()`. The names are:

| Name of raw data        | Name of tidy data        |
| :---------------------- | :----------------------  |
| `data_donor_one_raw`    | `data_donor_one_tidy`    |
| `data_donor_two_raw`    | `data_donor_two_tidy`    |
| `data_donor_three_raw`  | `data_donor_three_tidy`  |
| `data_donor_four_raw`   | `data_donor_four_tidy`   |

All of the tidy-functions needed to prepare the data as gathered in the wrapper `run_all_prep()`. The output of this function is a data frame, which can be used directly in the modelling functions. The modelling functions are as follows:

* `summarise_with_filter()`: A simple count of relevant binders stratified on user input. The output is a table.

* `relevant_binder_frequency_plot()`: The output is a plotly plot showing all relevant binding events between TCR-sequences and pMHC.

* `alpha_beta_pair_distribution()`: The function outputs a bar plot showing the distribution of alpha- beta chain composition. E.g., if a TCR-sequence only consists of an alpha chain, or perhaps only consists of a beta chain.

* `alpha_beta_sequence_consistency()`: A bar plot showing the relative distinctiveness of all the alpha and beta chains.

## Shiny Integration

This entire package is made to work with a Shiny App found [here](https://github.com/WilliamH-R/TCRSequenceShiny). The Shiny App gives an interactive interface for exploring and modelling the data sets mentioned in the above.

## Installation

```R
# Install the package from GitHub
devtools::install_github("WilliamH-R/TCRSequenceFunctions")
```

## Usage

```R
library(TCRSequenceFunctions)

data_donor_one_raw %>% 
    run_all_prep()
#> # A tibble: 512,264 x 27
#>   barcode      TCR_s~1 TCR_c~2 donor chain   CD3  CD19 CD45RA   CD4  CD8a  CD14
#>   <chr>        <chr>   <fct>   <chr> <chr> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 AAACCTGAGAC~ CAASVS~ other   dono~ alpha  2125     0    912     1  2223     4
#> 2 AAACCTGAGAC~ CAASVS~ other   dono~ alpha  2125     0    912     1  2223     4
#> 3 AAACCTGAGAC~ CAAWDM~ other   dono~ alpha  2125     0    912     1  2223     4
#> 4 AAACCTGAGAC~ CAAWDM~ other   dono~ alpha  2125     0    912     1  2223     4
#> 5 AAACCTGAGAC~ CAISDP~ other   dono~ beta   2125     0    912     1  2223     4
#> 6 AAACCTGAGAC~ CAISDP~ other   dono~ beta   2125     0    912     1  2223     4
#> 7 AAACCTGAGAC~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1
#> 8 AAACCTGAGAC~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1
#> 9 AAACCTGAGAC~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1
#>10 AAACCTGAGAG~ CASYTD~ one_al~ dono~ alpha  1598     3   3454     4  3383     1
#> # ... with 512,254 more rows, 16 more variables: CD45RO <dbl>,
#> #   `CD279_PD-1` <dbl>, IgG1 <dbl>, IgG2a <dbl>, IgG2b <dbl>, CD127 <dbl>,
#> #   CD197_CCR7 <dbl>, `HLA-DR` <dbl>, non_promiscuous_pair <chr>, pMHC <chr>,
#> #   allele <chr>, peptide <chr>, peptide_source <chr>, UMI_count <dbl>,
#> #   max_negative_control_binder <dbl>, is_binder <lgl>, and abbreviated variable
#> #   names 1: TCR_sequence, 2: TCR_combination
#> # i Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names

data_donor_one_tidy
#> # A tibble: 512,264 x 27
#>   barcode TCR_s~1 TCR_c~2 donor chain   CD3  CD19 CD45RA   CD4  CD8a  CD14 CD45RO CD279~3  IgG1 IgG2a
#>   <chr>   <chr>   <chr>   <chr> <chr> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl>  <dbl>   <dbl> <dbl> <dbl>
#> 1 AAACCT~ CAASVS~ other   dono~ alpha  2125     0    912     1  2223     4     13       1     3     2
#> 2 AAACCT~ CAASVS~ other   dono~ alpha  2125     0    912     1  2223     4     13       1     3     2
#> 3 AAACCT~ CAAWDM~ other   dono~ alpha  2125     0    912     1  2223     4     13       1     3     2
#> 4 AAACCT~ CAAWDM~ other   dono~ alpha  2125     0    912     1  2223     4     13       1     3     2
#> 5 AAACCT~ CAISDP~ other   dono~ beta   2125     0    912     1  2223     4     13       1     3     2
#> 6 AAACCT~ CAISDP~ other   dono~ beta   2125     0    912     1  2223     4     13       1     3     2
#> 7 AAACCT~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1      1       3     1     2
#> 8 AAACCT~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1      1       3     1     2
#> 9 AAACCT~ CASDTP~ one_be~ dono~ beta   1023     0   2028     2  3485     1      1       3     1     2
#>10 AAACCT~ CASYTD~ one_al~ dono~ alpha  1598     3   3454     4  3383     1      0       5     0     5
#> # ... with 512,254 more rows, 12 more variables: IgG2b <dbl>, CD127 <dbl>, CD197_CCR7 <dbl>,
#> #   `HLA-DR` <dbl>, non_promiscuous_pair <chr>, pMHC <chr>, allele <chr>, peptide <chr>,
#> #   peptide_source <chr>, UMI_count <dbl>, max_negative_control_binder <dbl>, is_binder <lgl>, and
#> #   abbreviated variable names 1: TCR_sequence, 2: TCR_combination, 3: `CD279_PD-1`
#> # i Use `print(n = ...)` to see more rows, and `colnames()` to see all variable names  

data_donor_one_tidy %>% 
    summarise_with_filter()
#> # A tibble: 34 x 4
#> # Groups:   allele, peptide, peptide_source [34]
#>   allele peptide    peptide_source      count
#>   <chr>  <chr>      <chr>               <int>
#> 1 A0201  CLLWSFQTSA Tyrosinase_Cancer       1
#> 2 A0201  ELAGIGILTV MART-1_Cancer         242
#> 3 A0201  FLASKIGRLV Ca2-indepen-Plip-A2     8
#> 4 A0201  FLYALALLL  LMP2A_EBV              21
#> 5 A0201  GILGFVFTL  Flu-MP_Influenza     2617
#> 6 A0201  GLCTLVAML  BMLF1_EBV              39
#> 7 A0201  IMDQVPFSV  gp100_Cancer            5
#> 8 A0201  KTWGQYWQV  gp100_Cancer            7
#> 9 A0201  KVLEYVIKV  MAGE-A1_Cancer          3
#>10 A0201  LLDFVRFMGV EBNA-3B_EBV           142
#> # ... with 24 more rows
#> # i Use `print(n = ...)` to see more rows

data_donor_one_tidy %>% 
    evaluate_binder(UMI_count_min = 20,
                            negative_control_UMI_count_min = 10) %>% 
    summarise_with_filter()
#> # A tibble: 30 x 4
#> # Groups:   allele, peptide, peptide_source [30]
#>   allele peptide    peptide_source      count
#>   <chr>  <chr>      <chr>               <int>
#> 1 A0201  CLLWSFQTSA Tyrosinase_Cancer       1
#> 2 A0201  ELAGIGILTV MART-1_Cancer         135
#> 3 A0201  FLASKIGRLV Ca2-indepen-Plip-A2     3
#> 4 A0201  FLYALALLL  LMP2A_EBV              18
#> 5 A0201  GILGFVFTL  Flu-MP_Influenza     2509
#> 6 A0201  GLCTLVAML  BMLF1_EBV              34
#> 7 A0201  IMDQVPFSV  gp100_Cancer            5
#> 8 A0201  KTWGQYWQV  gp100_Cancer            2
#> 9 A0201  KVLEYVIKV  MAGE-A1_Cancer          3
#> 10 A0201  LLDFVRFMGV EBNA-3B_EBV           136
#> # ... with 20 more rows
#> # i Use `print(n = ...)` to see more rows

```
