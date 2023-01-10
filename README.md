# TCRSequencesFunctions

## Overview

This package contains a series of functions to tidy and model data sets pertaining to Single Cell Immune Profiling. These data sets are also included in the package, and was made publicly available by 10x Genomics. (source: [10x Genomics](https://www.10xgenomics.com/resources/datasets?query=&page=1&configure%5Bfacets%5D%5B0%5D=chemistryVersionAndThroughput&configure%5Bfacets%5D%5B1%5D=pipeline.version&configure%5BhitsPerPage%5D=500&configure%5BmaxValuesPerFacet%5D=1000&menu%5Bproducts.name%5D=Single%20Cell%20Immune%20Profiling)).

The included raw data sets are:

* `data_donor_one_raw`: Data from donor one. Each row represent a cell from the donor. Columns contains either surface protein names or pMHCs and a column for the TCR-sequence. For the surface proteins, their expression levels are shown. For the pMHCs, the UMI-counts for the interactions between TCRs and pMHCS are noted. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-1-1-standard-3-0-2)

* `data_donor_two_raw`: Data from donor two. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-2-1-standard-3-0-2)

* `data_donor_three_raw`: Data from donor three. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-3-1-standard-3-0-2)

* `data_donor_four_raw`: Data from donor four. Follows the same structure as above. (Source: https://www.10xgenomics.com/resources/datasets/cd-8-plus-t-cells-of-healthy-donor-4-1-standard-3-0-2)

The raw data sets have been combined and tidied to create the data file `data_combined tidy`. The tidied data file is made an export of the package to avoid needing to re-tidy the raw files.

All of the tidy-functions needed to prepare the data as gathered in the wrapper `run_all_prep()`. The output of this function is a data frame, which can be used directly in the modelling functions. The modelling functions are as follows:

* `percentage_rows_kept()`: Shows percentage of data points left with the applied filtering compared to a baseline. The output is a table.

* `summarise_with_filter()`: A simple count of relevant binders stratified on a user input. The count is compared to the same baseline as mentioned above. The output is a table.

* `boxplot_protein_expressions()`: Boxplots showing the distribution of clr-transformed surface protein expression levels across all donors for each protein.

* `alpha_beta_sequence_consistency()`: A bar plot showing the relative distinctiveness of all alpha and beta chains. A low score means, that the type of sequence is not distinctive.

* `alpha_beta_category_distribution()`: The function outputs a bar plot showing the distribution of alpha and beta chain compositions. E.g., some T-cells only have an alpha chain whereas others have both an alpha and a beta chain.

* `count_binding_pr_allele()`: The HLA of pMHCs are checked against the donors' haplotype to see if relevant binders match. The output is a barplot showing count occurrences.

* `relevant_binders_plot()`: The output is an interactive scatter plot showing all relevant binding events between TCR-sequences and pMHC.

* `umap_of_protein_expressions()`: For each donor and for each protein a UMAP-model can be applied and coloured by the expression of a selected protein. It is a technique to plot high dimensional data in low dimensions. The output is a scatter plot.

## Shiny Integration

This entire package is made to work with a Shiny App found [here](https://github.com/WilliamH-R/ImmunoViz). The Shiny App gives an interactive interface for filtering, exploring and modelling the data sets mentioned in the above via the functions stated above. If the user is content with the data, it can be downloaded via the app along with some meta data.

## Installation

```R
# Install the package from GitHub
devtools::install_github("WilliamH-R/ImmunoCleaner")
```

## Usage

```R
library(ImmunoCleaner)

# A data frame can be created for each donor
data_donor_one_tidy <- data_donor_one_raw %>% 
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

# The created tidy data frame can then be used with the included functions
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

# The exported data frame can be used immediately
data_combined_tidy %>% 
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
