test_that("evaluation of relevant binder works for negative numbers", {
  data_test <- tibble::tibble(barcode = c(seq(1:12)),
                              UMI_count = c(-1, -10, -100, -1000,
                                            1, 10, 100, 1000,
                                            -1, -10, -100, -1000),
                              max_negative_control_binder = c(1, 10, 100, 1000,
                                                          -1, -10, -100, -1000,
                                                          -1, -10, -100, -1000))
  expected <- tibble::tibble(is_binder = c(FALSE, FALSE, FALSE, FALSE,
                                           FALSE, FALSE, TRUE, TRUE,
                                           FALSE, FALSE, FALSE, FALSE))
  expect_equal(evaluate_binder(data_test) %>%
                 dplyr::select(is_binder),
               expected)
})

test_that("evaluation of relevant binder works for expected cases", {
  data_test <- tibble::tibble(barcode = c(seq(1:12)),
                              UMI_count = c(1, 2, 3, 4,
                                            10, 20, 30, 40,
                                            100, 200, 300, 400),
                              max_negative_control_binder = c(0, 0, 0, 0,
                                                          5, 10, 2, 100,
                                                          30, 20, 1, 10))
  expected <- tibble::tibble(is_binder = c(FALSE, FALSE, FALSE, FALSE,
                                           FALSE, FALSE, TRUE, FALSE,
                                           FALSE, TRUE, TRUE, TRUE))
  expect_equal(data_test %>%
                 evaluate_binder() %>%
                 dplyr::select(is_binder),
               expected)
})

test_that("changing thresholds works as intended", {
  data_test <- tibble::tibble(barcode = c(seq(1:12)),
                              UMI_count = c(1, 2, 3, 4,
                                            10, 20, 30, 40,
                                            100, 200, 300, 400),
                              max_negative_control_binder = c(0, 0, 0, 0,
                                                          5, 10, 2, 100,
                                                          30, 20, 1, 10))
  expected <- tibble::tibble(is_binder = c(TRUE, TRUE, TRUE, TRUE,
                                           FALSE, FALSE, TRUE, FALSE,
                                           FALSE, FALSE, TRUE, TRUE))
  expect_equal(evaluate_binder(data_test,
                               UMI_count_min = 0,
                               negative_control_UMI_count_min = 10) %>%
                 dplyr::select(is_binder),
               expected)
})

test_that("identifier is present in data set", {
  data_test <- tibble::tibble(UMI_count = c(1, 2, 3, 4),
                              max_negative_control_binder = c(0, 0, 0, 0))
  expect_error(evaluate_binder(data_test), "is not found")
})
