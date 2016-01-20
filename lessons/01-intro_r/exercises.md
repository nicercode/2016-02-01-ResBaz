---
layout: lesson
root: ../..
title: Intro to R - exercises
tutor: Rich
---

Please try out these exercises from now until the break. Feel free to break if you're done with the exercise and don't flag us down if you're stuck and need any help.

# Exercise for session 01

1. Fix each of the following common data frame subsetting errors:

```
# Extract cases where cyl is 4
mtcars[mtcars$cyl = 4, ]

# Exclude only rows 1 through 4
mtcars[-1:4, ]

# Return only rows for cylinders less than 5
mtcars[mtcars$cyl <= 5]

# Return only rows for cylinders that are 4 or 6.
mtcars[mtcars$cyl == 4 | 6, ]
```

2. Why does `mtcars[1:20]` return a error? How does it differ from the similar `mtcars[1:20, ]`?


3. R comes with a data set called `iris`;

* How big is this dataset (number of rows and columns)?
* Create a new `data.frame` called `small_diamonds` that only contains rows 1 through 9 and 19 through 23. You can do this in one or two steps.

4. Given a linear model

```
mod <- lm(mpg ~ wt, data = mtcars)
```

Extract the residual degrees of freedom.
