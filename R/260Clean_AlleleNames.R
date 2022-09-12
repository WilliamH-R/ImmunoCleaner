allele_names <- function(data){ 
  data_clean <- 
    data %>% 
    separate(col = "allele_info",
             into = c("allele", "peptide", "peptide_source"),
             sep = "_",
             remove = FALSE,
             extra = "merge")
  return(data_clean)
}
