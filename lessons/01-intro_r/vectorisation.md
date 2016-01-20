---
layout: lesson
root: ../..
title: Some notes on vectorization
tutor: Rich
---


Many operations in R are vectorized which means that writing code is more efficient, concise and easy to read.

Idea with vectorized operations is that things can happen in parallel without needing to act on one element at a time.

```
x <- 1:4
y <- 6:9
```

add element wise

```
x + y
x > 2
x >= 2
```
returns logical vectors

```
y == 8

x * y

x / y
```

Matrix operations are also vectorized

```
x <- matrix(1:4, 2, 2)
y <- matrix(rep(10, 4), 2, 2)

x * y is not matrix multiplication. It's element wise

x / y is elementwise division.
```

True matrix multiplication is:

```
x %*% y
```

Vectorized operations make code a lot simpler.
