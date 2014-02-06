## Here's the functions from before:
linear.rescale <- function(x, r.out, r.in=range(x)) {
  if (length(r.out) != 2 || length(r.in) != 2)
    stop("r.in and r.out must be length 2")
  if (diff(r.in) <= 0)
    stop("r.in must be increasing")
  p <- (x - r.in[[1]]) / diff(r.in)
  r.out[[1]] + p * diff(r.out)
}

library(testthat)


test_that("Rescale gives expected range", {
  r.out <- sort(runif(2))
  expect_that(range(linear.rescale(x, r.out)), equals(r.out))
  expect_that(range(linear.rescale(x, rev(r.out))), equals(r.out))
  expect_that(linear.rescale(x, rev(r.out)),
              equals(sum(r.out) - linear.rescale(x, r.out)))
  expect_that(linear.rescale(x, r.out, r.out), equals(x))
})

test_that("Bad inputs for r.out", {
  expect_that(linear.rescale(x, numeric(0)),  throws_error())
  expect_that(linear.rescale(x, 1),           throws_error())
  expect_that(linear.rescale(x, 1:3),         throws_error())
  expect_that(linear.rescale(x, c("a", "b")), throws_error())

  expect_that(linear.rescale(x, c(1, NA)),
              equals(rep(NA_real_, length(x))))
})

test_that("Bad inputs for r.in", {
  r.out <- sort(runif(2))
  expect_that(linear.rescale(x, r.out, numeric(0)),  throws_error())
  expect_that(linear.rescale(x, r.out, 1),           throws_error())
  expect_that(linear.rescale(x, r.out, 1:3),         throws_error())
  expect_that(linear.rescale(x, r.out, c("a", "b")), throws_error())
})
