---
layout: lesson
root: ../..
title: Testing your code
tutor: Rich FitzJohn
---

http://programmers.stackexchange.com/a/147080

> Unless you are going to write code without testing it, you are always going to incur the cost of testing.

> The difference between having unit tests and not having them is the difference between the cost of writing the test and the cost of running it compared to the cost of testing by hand.

> If the cost of writing a unit test is 2 minutes and the cost of running the unit test is practically 0, but the cost of manually testing the code is 1 minute, then you break even when you have run the test twice.



Testing is often introduced as a last-minute thing, but most scientists who write code do an informal version of testing as they develop.

Software testing is a process by which one or more expected behaviours and results from a piece of software are exercised and confirmed. Well chosen tests will confirm expected code behaviour for the extreme boundaries of the input domains, output ranges, parametric combinations, and other behavioural edge cases.

# Why test software?

Unless you write flawless, bug-free, perfectly accurate, fully precise,and predictable code **every time**, you must test your code in order to trust it enough to answer in the affirmative to at least a few of the following questions:

-   Does your code work?
-   **Always?**
-   Does it do what you think it does? ([Patriot Missile Failure](http://www.ima.umn.edu/~arnold/disasters/patriot.html)),  Software Glitch Means Loss of NASA's Deep Impact Comet Probe [1](http://science.slashdot.org/story/13/09/20/2356211/software-glitch-means-loss-of-nasas-deep-impact-comet-probe), [2](http://science.slashdot.org/story/04/11/28/099245/nasas-deep-impact)
-   Does it continue to work after changes are made?
-   Does it continue to work after system configurations or libraries
    are upgraded?
-   Does it respond properly for a full range of input parameters?
-   What about **edge or corner cases**?
-   What's the limit on that input parameter?
-   How will it affect your
    [publications](http://www.nature.com/news/2010/101013/full/467775a.html)?

# When should we test?

The three right answers are:

-   **ALWAYS!**
-   **EARLY!**
-   **OFTEN!**    

The longer answer is that testing either before or after your software is written will improve your code, but testing after your program is used for something important is too late.

## Why testing is important?

**Seems like extra work but will save you time**  
* Decreased frustration. Bugs appear very close to hard deadlines.  Testing allows to quickly identify where the problem is and fix it.

**More confidence in the code**  
* Better code structure. Code that is easy to test is usually better designed. Tests sometimes make you see large complicated functions and break them down into smaller, more manageable chunks.

**Make changes or updates without worrying too much**  
* Make changes confidently because you know your tests will catch any issues.

Getting more serious about testing has totally changed my approach towards software development over the last year.  I find that I now write programs that are better separated into component parts, that define their roles more clearly, that have fewer bugs or unexpected behaviours and that are easier to modify as I go along.

## Basics of testing

We'll use the `testthat` package to make testing easy and intuitive.  This is a brilliant package that scales up from one-off tests to detailed suites that are well suited to large packages.

```coffee
library(testthat)
```

In the previous section we created a function that linearly rescales values.

```coffee
linear.rescale <- function(x, r.out, r.in=range(x)) {
  p <- (x - r.in[[1]]) / diff(r.in)
  r.out[[1]] + p * diff(r.out)
}
```

This is a simple function, and one that we could use elsewhere.  But especially if we do use it elsewhere we want to know how it behaves.  So we write tests partly to document how it will react in particular edge cases.

It also means that if we depend on it, we are free to change how it is implemented internally (adding a new argument, or changing the underlying algorithm, etc) and if the tests still agree then the code that depends on the function will still behave correctly *if we have written the tests well*.

Behaving correctly

* Range of rescaled data should be `r.out`
* r.out and r.in identical (no change)

Corner cases:

* no x values given, no r.in given
* r.out or r.in not sorted
* r.out or r.in not of length 2
* deal correctly with negative values

We already ran through some of these when developing the function the first time.

```coffee
x <- rnorm(20)
```

```coffee 
r.out <- c(0.1, 1.4)
range(linear.rescale(x, r.out)) == r.out
```

```coffee
expect_that(range(linear.rescale(x, r.out)), equals(r.out))
```

That is the idea.  There are some issues around where to store the tests, but that's not hard to sort out.

### Expectations


**1. `equals()` Equality with a numerical tolerence**
````
# passes
expect_that(10, equals(10))
# passes
expect_that(10, equals(10 + 1e-7))
# Fails
expect_that(10, equals(10 + 1e-6))
# Definitely fails!
expect_that(10, equals(11))
```

**2. `is_identical_to`:  Exact quality with identical**

```
expect_that(10, is_identical_to(10))
expect_that(10, is_identical_to(10 + 1e-10))
```

**3. `is_equivalent_to()` is a more relaxed version of equals()**

```
# ignores attribute names
expect_that(c("one" = 1, "two" = 2), is_equivalent_to(1:2))
```

**4. `is_a()` checks that an object inherit()s from a specified class**  

```
model <- lm(mpg ~ cyl, mtcars)
expect_that(model, is_a("lm"))
```


**5. `matches()` matches a character vector against a regular expression.**

```
string <- "Testing is fun!"
# Passes
expect_that(string, matches("Testing"))
```

**6. `prints_text()` matches the printed output from an expression against a regular expression**

```
a <- list(1:10, letters)
# Passes
expect_that(str(a), prints_text("List of 2"))
# Passes
expect_that(str(iris), prints_text("data.frame"))
```


**7. `shows_message()` checks that an expression shows a message**

```
expect_that(library(mgcv),
shows_message("This is mgcv"))
```

**8. `gives_warning()` expects that you get a warning**

```
expect_that(log(-1), gives_warning())
expect_that(log(-1),
  gives_warning("NaNs produced"))
# Fails
expect_that(log(0), gives_warning())
```

**9. `throws_error()` verifies that the expression throws an error. You can also supply a regular expression which is applied to the text of the error**

```
expect_that(1 / 2, throws_error())
expect_that(seq_along(1:NULL), throws_error())
```


**10. `is_true()` is a useful catchall if none of the other expectations do what you want -it checks that an expression is true**

```
x <- require(ggplot2)
expect_that(x, is_true())
```

This entire suite of tests can also be shortened.

| Long form | Short form |
| -------   | ---------  | 
| expect_that(x, is_true()) | expect_true(), expect_false() |
| expect_that(x, is_true()) | expect_true(), expect_false() |
| expect_that(x, is_a(y)) | expect_is(x, y) |
| expect_that(x, equals(y)) | expect_equal(x, y) |
| expect_that(x, is_equivalent_to(y)) | expect_equivalent(x, y) |
| expect_that(x, is_identical_to(y)) | expect_identical(x, y) |
| expect_that(x, matches(y)) |  expect_matches(x, y) |
| expect_that(x, prints_text(y)) | expect_output(x, y)  |
| expect_that(x, shows_message(y)) | expect_message(x, y) |
| expect_that(x, gives_warning(y)) |  expect_warning(x, y) |
| expect_that(x, throws_error(y)) |  expect_error(x, y) |


What if `r.out` is not sorted?

```
r.out <- rev(r.out)
plot(x, linear.rescale(x, r.out))
```

So, decide -- either disallow reversed ranges in the function or treat this as a feature.

```coffee
linear.rescale <- function(x, r.out, r.in=range(x)) {
  if (diff(r.in) <= 0) # or !is.unsorted(r.in)
    stop("r.in must be increasing")
  p <- (x - r.in[[1]]) / diff(r.in)
  r.out[[1]] + p * diff(r.out)
}
```















**Acknowledgements**: This material was adapted from ... and modified by ...

Katy Huff, Rachel Slaybaugh, and Anthony Scopatz (canberra/07-testing/README.md, looks based on thw-testing/testing-orig.md)
