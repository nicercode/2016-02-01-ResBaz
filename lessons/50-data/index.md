---
layout: lesson
root: ../..
title: Data analysis
tutor: Daniel Falster
---

Goals

- use of functions
- use of control structures
- debug function
- split apply combine strategy for data analysis
- show how functions extend function to new problem

13:45 - 14:15 	Repeating things
--> one example of each
* lapply:
	- about lists
	- example: list countries per continent, function to describe continent: name, countries, population per continent, max life expectancy per continent
* for loops:
 	make plot for each country or continent
* introduction to split apply combine strategy & dplyr
	- group_by, arrange, summarise, mutate

14:15 - 14:35 	Break

14:35 - 16:20 	Data analysis (free coding, opportunity to try different methods we have mentioned)

1. Apply functions and repeating to gapminder data  (30mins)

* provide with expanded database from gapminder (more variables, or function to build dataset)
* Let them choose their own variables: work in pairs, give 5 mins to come up with own problem, then ask to tell class
* Come up with function, test it, implement across dataset

2. Interlude: how to debug function.
	- browser(), scope

3. More data analysis

4. Interlude: a bit about plotting
	- code always ugly.
	- use functions to make do nice figures
	- Example: blankplot, label, world map, to.pdf
	- Showcase: nice plots we have made

4. More data analysis (apply to.pdf to their plots)

16:20 - 16:30 Tell us what you've discovered about the world

16:30 - 17:00 Principles of nice code

# Principles of writing nice code (in R)

Conclusion to day 1, wrapping up core messages about code development

Here are some reasons to write your own functions

- Readability  - the most important part of writing code.
- bugs: avoid scope-related and mutability bugs.  E.g., a global
	variable 'x' that is used in multiple places.
- reuse -- especially within a project. DRY
- easier to test and to debug

### Making code more readable

Readability is **the** most important part of writing nice code.

Ideally your scripts should be short and readable, anyone should be able to pick them up and understand what it does.

TODO: example of nice code and bad code
 - illustrate with example? Download some ugly and nice code, tell us what they did

Several things important here

- describe the what not the how -- function names tell you what the
code *will* do, not the mechanics of *how* it will do it.
- clean up scope -- more easily reason about the behaviour of the program; keep local environment clean

**Tell us what your function is doing, not how**

The most important thing that writing functions helps is for you to
concentrate on writing code that describes *what* will happen, not
*how* it will happen.  The *how* becomes an implementation issue that
you don't have to worry about.

**Keep your analysis script small by moving R functions into another file**

For R to be able to execute your function, it needs first to be read
into memory. This is just like loading a library, until you do it the
functions contained within it cannot be called.

There are two methods for loading functions into the memory:

1. Copy the function text and paste it into the console
2. Use the `source()` function to load your functions from file.

Our recommendation for writing nice R code is that in most cases, you
should use the second of these options. Put your functions into a file
with an intuitive name, like `analysis-fun.R`. You
can then read the function into memory by calling:

```
source("analysis-fun.R")
```

From the point of view of writing nice code, this approach is nice
because it leaves you with an uncluttered analysis script, and a
repository of useful functions that can be loaded into any analysis
script in your project.  It also lets you group related functions
together easily.

### Break down problem into bite size pieces

Cognitive bandwidth

### Keep workspace clean - helps avoid bugs from multiple data objects

By using functions, you limit the **scope** of variables.  In the
`logit` function, the `p` variable is only valid within the body of
the `logit` function -- it is unaffected by any other variable called
`p` and it does not affect any other variable called `p`.  This means
when you read code you don't have to look elsewhere to reason about
what values variables might take.

Along similar lines, as much as possible functions should be self
contained and not depend on things like global variables (these are
variables you've defined in the main workspace that would show up in
RStudio's object list).

### Know that your code is doing the right thing

Testing

### Becoming more productive

Functions enable easy reuse within a project, helping you not to
repeat yourself.  If you see blocks of similar lines of code through
your project, those are usually candidates for being moved into
functions.

If your calculations are performed through a series of functions, then
the project becomes more modular and easier to change.  This is
especially the case for which a particular input always gives a
particular output.


**Acknowledgements**: This material was adapted from ... and modified by ...

