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
  x <- rnorm(20)
  r.out <- sort(runif(2))
  expect_that(range(linear.rescale(x, r.out)), equals(r.out))
  expect_that(range(linear.rescale(x, rev(r.out))), equals(r.out))
  expect_that(linear.rescale(x, rev(r.out)),
              equals(sum(r.out) - linear.rescale(x, r.out)))
  expect_that(linear.rescale(x, r.out, r.out), equals(x))
})

test_that("Bad inputs for r.out", {
  x <- rnorm(20)
  expect_that(linear.rescale(x, numeric(0)),  throws_error())
  expect_that(linear.rescale(x, 1),           throws_error())
  expect_that(linear.rescale(x, 1:3),         throws_error())
  expect_that(linear.rescale(x, c("a", "b")), throws_error())

  expect_that(linear.rescale(x, c(1, NA)),
              equals(rep(NA_real_, length(x))))
})

test_that("Bad inputs for r.in", {
  x <- rnorm(20)
  r.out <- sort(runif(2))
  expect_that(linear.rescale(x, r.out, numeric(0)),  throws_error())
  expect_that(linear.rescale(x, r.out, 1),           throws_error())
  expect_that(linear.rescale(x, r.out, 1:3),         throws_error())
  expect_that(linear.rescale(x, r.out, c("a", "b")), throws_error())
})

## Rename

## Cases to test for:

## Empty tr leaves x unchanged
## Things not in tr are untouched
## Things in tr not in x
## Unnamed tr
## Duplicate names in either tr or x (yuck)
rename <- function(x, tr) {
  i <- match(names(tr), names(x))
  names(x)[i] <- tr
  x
}

test_that("Empty tr leaves x unchanged", {
  x <- c(a=1, b=2)
  expect_that(rename(x, NULL),         is_identical_to(x))
  expect_that(rename(x, c()),          is_identical_to(x))
  expect_that(rename(x, character(0)), is_identical_to(x))
})

test_that("Things not in tr left untouched", {
  x <- c(a=1, b=2)
  tr <- c(a="apple")
  res <- rename(x, tr)
  expect_that(names(res), equals(c("apple", "b")))
  expect_that(unname(res), is_identical_to(unname(x)))
})

test_that("Values in tr not in x cause warning", {
  x <- c(a=1, b=2)
  tr <- c(a="apple", c="cabbage")
  expect_that(names(rename(x, tr)), equals(c("apple", "b")))
  expect_that(rename(x, tr), gives_warning())
})

rename <- function(x, tr) {
  if (!all(names(tr) %in% names(x)))
    warning("Keys in 'tr' that are not in 'x': ",
            paste(setdiff(names(tr), names(x)), collapse=", "))
  i <- match(names(tr), names(x))
  j <- !is.na(i)
  names(x)[i[j]] <- tr[j]
  x
}

test_that("Values in tr not in x cause warning", {
  x <- c(a=1, b=2)
  tr <- c(a="apple", c="cabbage")
  expect_that(res <- rename(x, tr), gives_warning())
  expect_that(names(res), equals(c("apple", "b")))
})

rename <- function(x, tr) {
  if (!all(names(tr) %in% names(x)))
    stop("Keys in 'tr' that are not in 'x': ",
         paste(dQuote(setdiff(names(tr), names(x))), collapse=", "))
  i <- match(names(tr), names(x))
  names(x)[i] <- tr
  x
}

test_that("Values in tr not in x cause error", {
  x <- c(a=1, b=2)
  tr <- c(a="apple", c="cabbage")
  expect_that(res <- rename(x, tr), throws_error())
})


test_that("Unnamed tr causes an error", {
  x <- c(a=1, b=2)
  tr <- c("apple", b="banana")
  expect_that(rename(x, tr), throws_error())
})
