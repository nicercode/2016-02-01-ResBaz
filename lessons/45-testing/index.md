---
layout: lesson
root: ../..
title: Testing your code
tutor: Rich FitzJohn
---

> Unless you are going to write code without testing it, you are always going to incur the cost of testing.

> The difference between having unit tests and not having them is the difference between the cost of writing the test and the cost of running it compared to the cost of testing by hand.

> If the cost of writing a unit test is 2 minutes and the cost of running the unit test is practically 0, but the cost of manually testing the code is 1 minute, then you break even when you have run the test twice. ([source](http://programmers.stackexchange.com/a/147080))

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
rescale <- function(x, r.out) {
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}
```

This is a simple function, and one that we could use elsewhere.  But especially if we do use it elsewhere we want to know how it behaves.  So we write tests partly to document how it will react in particular edge cases.

It also means that if we depend on it, we are free to change how it is implemented internally (adding a new argument, or changing the underlying algorithm, etc) and if the tests still agree then the code that depends on the function will still behave correctly *if we have written the tests well*.

Behaving correctly

* Range of rescaled data should be `r.out`
* If `r.out` is the same as the range of the input data (`range(x)`), the data should be unchanged.

Corner cases:

* no x values given, or empty vector of values
* no r.out given
* r.out not of length 2
* r.out not sorted
* Does the function deal correctly with negative values?
* missing values in x

We already ran through some of these when developing the function the first time.

```coffee
x <- rnorm(20)
```

```coffee
r.out <- c(0.1, 1.4)
range(rescale(x, r.out)) == r.out
```

```coffee
expect_that(range(rescale(x, r.out)), equals(r.out))
```

Note that this does not produce output!  It will only produce output if the test fails, in which case it will appear as an error.  Alternatively, when running non-interactively, we'll see indications that individual tests have passed.

That is the idea.  There are some issues around where to store the tests, but that's not hard to sort out.

### Expectations


* **`equals()` Equality with a numerical tolerence**

````
expect_that(10, equals(10)) # passes

expect_that(10, equals(10 + 1e-7)) # passes

expect_that(10, equals(10 + 1e-6)) # fails

expect_that(10, equals(11)) # fails
```

* **`is_identical_to`:  Exact quality with identical** (this can be surprising with decimal numbers)

```
expect_that(10, is_identical_to(10))
expect_that(10, is_identical_to(10 + 1e-10))
```

* **`is_a()` checks that an object inherit()s from a specified class**

```
model <- lm(mpg ~ cyl, mtcars)
expect_that(model, is_a("lm"))
```


* **`matches()` matches a character vector against a "regular expression".**

```
string <- "Testing is fun!"
# Passes
expect_that(string, matches("Testing"))
```

* **`prints_text()` matches the printed output from an expression against a regular expression**

```
a <- list(1:10, letters)
# Passes
expect_that(str(a), prints_text("List of 2"))
# Passes
expect_that(str(iris), prints_text("data.frame"))
```

* **`shows_message()` checks that an expression shows a message**

```
expect_that(library(mgcv),
shows_message("This is mgcv"))
```

* **`gives_warning()` expects that you get a warning**

```
expect_that(log(-1), gives_warning())
expect_that(log(-1),
  gives_warning("NaNs produced"))
# Fails
expect_that(log(0), gives_warning())
```

* **`throws_error()` verifies that the expression throws an error. You can also supply a regular expression which is applied to the text of the error**.  This one is *very* useful.

```
expect_that(1 / 2, throws_error())
expect_that(seq_along(1:NULL), throws_error())
```


* **`is_true()` is a useful catchall if none of the other expectations do what you want -it checks that an expression is true**

```
x <- require(plyr)
expect_that(x, is_true())
```

# Where to store things

* Functions go in a script file that can be sourced (say `functions.R`).
* Tests go in a file begining with `test-` (e.g., `test-rescale.R`).
* At the top of the testing file, source your functions file ane load `testthat`
* From within R, you can now do

```
library(testthat)
test_dir(".")
```

Storing things in different directories ends up being the long-term bet, but you can run into pathname issues here.

# Exercises

Start with the `rescale` function from before:

```coffee
rescale <- function(x, r.out) {
  p <- (x - min(x)) / (max(x) - min(x))
  r.out[[1]] + p * (r.out[[2]] - r.out[[1]])
}
```

Write tests to check that

* The function does rescale onto the correct range.
* Deals with bad input for `r.out` (wrong length, wrong type)
* Deals with missing values in the input (this will likely require rewriting the function a bit).

**Instructors:** Code that works through this is available in [exercises.R](exercises.R)

**Acknowledgements**: This material was developed by Rich FitzJohn, drawing on from material developed by Katy Huff, Rachel Slaybaugh, Anthony Scopatz and Karthik Ram.
