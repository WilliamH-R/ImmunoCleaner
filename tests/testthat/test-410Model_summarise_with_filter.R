test_that("statification works", {
  data_test <- tibble::tibble(barcode = seq(1:24),
                              is_binder = rep(TRUE, 24),
                              allele = c("A0201", "A1101", "A0201", "A1101", "A0201", "A1101",
                                         "A0301", "A0301", "A1101", "A0201", "B0702", "A0201",
                                         "B0702", "A0201", "A0301", "B0801", "B0801", "A0201",
                                         "A0301", "A0301", "A1101", "A0201", "A0301", "A0301"),
                              peptide = c("KLQCVDLHV", "AVFDRKSDAK", "KLQCVDLHV", "AVFDRKSDAK",
                                          "KLQCVDLHV", "AVFDRKSDAK", "KLGGALQAK", "RLRAEAQVK",
                                          "AVFDRKSDAK", "CLLGTYTQDV", "QPRAPIRPI", "CLLGTYTQDV",
                                          "QPRAPIRPI", "GILGFVFTL", "KLGGALQAK", "RAKFKQLL",
                                          "FLRGRAYGL", "KVAELVHFL", "KLGGALQAK", "RLRAEAQVK",
                                          "AVFDRKSDAK", "KVAELVHFL", "KLGGALQAK", "RLRAEAQVK"),
                              peptide_source = c("PSA146-154", "EBNA-3B_EBV", "PSA146-154",
                                                 "EBNA-3B_EBV", "PSA146-154", "EBNA-3B_EBV",
                                                 "IE-1_CMV", "EMNA-3A_EBV", "EBNA-3B_EBV",
                                                 "Kanamycin-B-dioxygenase", "EBNA-6_EBV",
                                                 "Kanamycin-B-dioxygenase", "EBNA-6_EBV",
                                                 "Flu-MP_Influenza", "IE-1_CMV", "BZLF1_EBV",
                                                 "EBNA-3A_EBV", "MAGE-A3_Cancer", "IE-1_CMV",
                                                 "EMNA-3A_EBV", "EBNA-3B_EBV", "MAGE-A3_Cancer",
                                                 "IE-1_CMV", "EMNA-3A_EBV"))
  expected <- c(4, 2, 3, 4)
  expect_equal(data_test %>%
                 summarise_with_filter() %>%
                 ncol(),
               expected[1])
  expect_equal(data_test %>%
                 summarise_with_filter(summarise_by = "allele") %>%
                 ncol(),
               expected[2])
  expect_equal(data_test %>%
                 summarise_with_filter(summarise_by = c("allele",
                                                        "peptide")) %>%
                 ncol(),
               expected[3])
  expect_equal(data_test %>%
                 summarise_with_filter(summarise_by = c("allele",
                                                        "peptide",
                                                        "peptide_source")) %>%
                 ncol(),
               expected[4])
})
