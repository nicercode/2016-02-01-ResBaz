library(testthat)

## Here's the function from before:
rescale <- function(x, r.out) {
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

test_that("Rescale gives expected range", {
  x <- rnorm(20)
  r.out <- sort(runif(2))
  ## Range is expected:
  expect_that(range(rescale(x, r.out)), equals(r.out))
  ## Rescaling onto same range does not change the data:
  expect_that(rescale(x, range(x)), equals(x))

  ## Rescaling onto a reversed range works
  expect_that(range(rescale(x, rev(r.out))), equals(r.out))
  ## And the output is what was expected:
  expect_that(rescale(x, rev(r.out)),
              equals(sum(r.out) - rescale(x, r.out)))
})

## Defensive programming: this is what we'd like to happen:
test_that("Bad inputs for r.out", {
  x <- rnorm(20)
  expect_that(rescale(x, numeric(0)),  throws_error())
  expect_that(rescale(x, 1),           throws_error())
  expect_that(rescale(x, 1:3),         throws_error())
  expect_that(rescale(x, c("a", "b")), throws_error())

  expect_that(rescale(x, c(1, NA)),
              equals(rep(NA_real_, length(x))))
})

## But we'll need to harden the function a bit:
rescale <- function(x, r.out) {
  if (length(r.out) != 2)
    stop("Expected r.out to be length 2")
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

## Or:
library(assertthat)
rescale <- function(x, r.out) {
  assert_that(length(r.out) == 2)
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

## NA values in the input:
test_that("Rescale gives expected range", {
  x <- rnorm(20)
  x[4] <- NA
  r.out <- sort(runif(2))
  ## Range is expected:
  expect_that(range(rescale(x, r.out)), equals(r.out))
  ## Rescaling onto same range does not change the data:
  expect_that(rescale(x, range(x)), equals(x))

  ## Rescaling onto a reversed range works
  expect_that(range(rescale(x, rev(r.out))), equals(r.out))
  ## And the output is what was expected:
  expect_that(rescale(x, rev(r.out)),
              equals(sum(r.out) - rescale(x, r.out)))
})

## More tweaks to the function:
rescale <- function(x, r.out) {
  assert_that(length(r.out) == 2)
  xr <- range(x, na.rm=TRUE)
  p <- (x - min(xr)) / (max(xr) - min(xr))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}

test_that("Rescale gives expected range", {
  x <- rnorm(20)
  x[4] <- NA
  r.out <- sort(runif(2))
  ## Range is expected:
  expect_that(range(rescale(x, r.out), na.rm=TRUE), equals(r.out))
  ## Rescaling onto same range does not change the data:
  expect_that(rescale(x, range(x, na.rm=TRUE)), equals(x))

  ## Rescaling onto a reversed range works
  expect_that(range(rescale(x, rev(r.out)), na.rm=TRUE), equals(r.out))
  ## And the output is what was expected:
  expect_that(rescale(x, rev(r.out)),
              equals(sum(r.out) - rescale(x, r.out)))
})

## What about cases where 



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
