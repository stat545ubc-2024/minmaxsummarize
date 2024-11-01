library(testthat)

test_that("shrink_and_summarize pass normal checks", {
  x <- c(0, 1, 2)
  result <- shrink_and_summarize(x, lower_limit = 0, upper_limit = 1)

  expect_type(result, "list")

  expect_true(all(result$prepared >= 0 & result$prepared <= 1))

  expect_equal(nrow(result$summary), 3)
  expect_equal(result$summary$statistic, c("mean", "median", "sd"))
})

test_that("shrink_and_summarize handles NA", {
  x <- c(0, 1, NA, 2)
  result <- shrink_and_summarize(x, lower_limit = 0, upper_limit = 1, na.rm = TRUE)
  expect_true(is.na(result$prepared[3]))
  expect_false(any(is.na(result$summary$value)))

  # Test with na.rm = FALSE
  shrink_and_summarize(x, lower_limit = 0, upper_limit = 10, na.rm = FALSE)
})

test_that("shrink_and_summarize single value", {
  x <- c(5)
  result_single <- shrink_and_summarize(x, lower_limit = 0, upper_limit = 2)
  expect_equal(result_single$prepared, 1)
})
