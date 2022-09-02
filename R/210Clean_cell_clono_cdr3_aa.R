vdj_v1_hs_aggregated_donor1_binarized_matrix %>% 
  select(cell_clono_cdr3_aa) %>% 
  mutate(cell_clono_cdr3_aa_TRA = str_match_all(cell_clono_cdr3_aa,
                                              "TRA:(\\w+)")[[1]][,2])



stri_extract_all("TRA:CAARVRGFGNVLHC;TRA:CAGHTGNQFYF;TRA:CAVGDNFNKFYF;TRB:CASSWGGGSHYGYTF;TRB:CASSLYSATGELFF",
              "TRA:(\\w+)")

library("stringi")
stri_extract_last_charclass("TRA:CAARVRGFGNVLHC;TRA:CAGHTGNQFYF;TRA:CAVGDNFNKFYF;TRB:CASSWGGGSHYGYTF;TRB:CASSLYSATGELFF",
                            "TRA:(\\w+)")
