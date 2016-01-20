---
layout: lesson
root: ../..
title: Some principles for writing nice code (in R)
tutor: Daniel Falster
---

Let's look at what we've learnt so far about code development.

Discuss with students how some  of the things they have learnt  will help improve their code.

### Making code more readable

Readability is **the** most important part of writing nice code.

Ideally your scripts should be short and readable, anyone should be able to pick them up and understand what it does.

### Tell us what your function is doing, not how

The most important thing that writing functions helps is for you to
concentrate on writing code that describes *what* will happen, not
*how* it will happen.  The *how* becomes an implementation issue that
you don't have to worry about.

### Keep your analysis script small by moving R functions into another file

Our recommendation for writing nice R code is that in most cases, you
should put your functions into a file
with an intuitive name, like `analysis-fun.R` and read these into memory by calling:

```
source("analysis-fun.R")
```

From the point of view of writing nice code, this approach is nice
because it leaves you with an uncluttered analysis script, and a
repository of useful functions that can be loaded into any analysis
script in your project.  It also lets you group related functions
together easily.

### Break down problem into bite size pieces

Corresponding with a single operation, single function.

### Know that your code is doing the right thing

By testing your functions!

### Keep workspace clean - helps avoid bugs from multiple data objects

By using functions, you limit the **scope** of variables. As much as possible functions should be self contained and not depend on things like global variables (these are variables you've defined in the main workspace that would show up in RStudio's object list).   This means
when you read code you don't have to look elsewhere to reason about
what values variables might take.

### Don't repeat yourself

Functions enable easy reuse within a project.  If you see blocks of similar lines of code through your project, those are usually candidates for being moved into functions.

If your calculations are performed through a series of functions, then
the project becomes more modular and easier to change.  This is
especially the case for which a particular input always gives a
particular output.

### Remember to be stylish

Applying consistent style to your code, such as that recommended in the [google's R style guide](https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml), makes your code more readable.
