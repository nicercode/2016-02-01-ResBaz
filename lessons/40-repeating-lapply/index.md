---
layout: lesson
root: ../..
title: Repeating things -- the key to good data analysis in R
tutor: Daniel Falster
---

<!-- Goals

- learn how to key control structures
- learn how to debug a function using browser
- split apply combine strategy for data analysis

Approach

Show them one
Get them do second with you
Assign them
 -->

## Don't repeat yourself

Previously we looked at how you can use functions to simplify your
code. Ideally you have a function that performs a single
operation, and now you want to use it many times to do the same operation on
lots of different data. The naive way to do that would be something like this:

```coffee
  res1 <-  f(input1)
  res2 <-  f(input2)
  ...
  res10 <-  f(input10)
```

But this isn't very *nice*. Yes, by using a function, you have reduced
a substantial amount of repetition. That **is** nice. But there is
still repetition.  Repeating yourself will cost you time, both now and
later, and potentially introduce some nasty bugs. When it comes to
repetition, well, just don't.

The nice way of repeating elements of code is to use a loop of some
sort. A loop is a coding structure that reruns the same bit of code
over and over, but with only small fragments differing between
runs. In R there is a whole family of looping functions, each with
their own strengths.

##The apply family

There are several related function in R which allow you to apply some function
to a series of objects (eg. vectors, matrices, dataframes or files). They include:

- `lapply`
- `sapply`
- `tapply`
- `aggregate`
- `mapply`
- `apply`.

Each repeats a function or operation on a series of elements, but they
differ in the data types they accept and return. What they all in
common is that **order of iteration is not important**.  This is
crucial. If each each iteration is independent, then you can cycle
through them in whatever order you like. Generally, we argue that you
should only use the generic looping functions `for`, `while`, and
`repeat` when the order or operations **is** important. Otherwise
reach for one of the apply tools.

## lapply and sapply

`lapply` applies a function to each element of a list (or vector),
collecting results in a list.  `sapply` does the same, but will try to
*simplify* the output if possible.

Lists are a very powerful and flexible data structure that few people seem to
know about. Moreover, they are the building block for other data structures,
like `data.frame` and `matrix`. To access elements of a list, you use the
double square bracket, for example `X[[4]]` returns the fourth element of the
list `X`. If you don't know what a list is, we suggest you [read more
about them](http://cran.r-project.org/doc/manuals/R-intro.html#Lists-and-
data-frames).

### Basic syntax

```coffee
result <- lapply(X, f, ...)
```

Here `X` is a list or vector, containing the elements that form the input to the function `f`. This code will also return a list, stored in `result`, with same number of elements as `X`.

### Examples

For an example, let's pull up gapminder dataset as before

```coffee
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
```

Now, what is we want to extra the list of countries by continent. So make a function to extract list of countries for a given continent

```coffee
get.countries <- function(cont,mydata){unique(mydata[mydata$continent==cont,]$country)}
````

Now try for one continent:

```
get.countries("Asia", data)
```

Now we had better test it

```coffee
library(testthat)
expect_that(get.countries("Oceania", data), equals(c("Australia","New Zealand")))
```

Now apply to other continents

```
get.countries("Africa", data)
get.countries("Americas", data)
...
```

Notice that there is only one thing varying per call -- the continent name. so now we're in a perfect position to call lapply. First, let's make a variable `continents`. We have to pass in another argument, the `data` variable, but that stays the same.

```coffee
continents <- unique(data$continent)
```
So now we can apply it to all continents:

```coffee
countries <- lapply(continents, get.countries, data=data)
names(countries) <- continents
```

So what if we ant to extract the total population of each continent in 2007. Again, let's make a function that does it for a single continent

```coffee
get.population <- function(cont,year, mydata){sum(mydata[mydata$continent==cont & mydata$year==year,]$pop)}
```

Now we had better test it

```coffee
Asia2007 <- subset(data, continent=="Asia" & year ==2007)
expect_that(get.population("Asia", 2007, data), equals(sum(Asia2007$pop)))
```

Finally, apply to entire dataset

```coffee
populations <- sapply(continents, get.population, data=data, year=2007)
```

**Your challenge**: Now find number of countries in each continent

```coffee
get.n.countries <- function(cont,data){length(unique(data[data$continent==cont,]$country))}
sapply(continents, get.n.countries, data=data)
```

OR you could use earlier result and feed that into lapply

```coffee
lapply(countries, length)
```

extra step here to name output, also use sapply to simplify reasult into vetcor

```coffee
nCountries <- data.frame(continents, ncountries = sapply(countries, length))
```

This last example highlights a strength of lapply, it's great for building analysis pipelines, where you want to repeat a series of steps on a large number of similar objects.  The way to do this is to
have a series of lapply statements, with the output of one providing the input to another.

```coffee
first.step <- lapply(X, first.function)
second.step <- lapply(first.step, next.function)
```

The challenge is to identify the parts of your analysis that stay the same and
those that differ for each call of the function. The trick to using `lapply` is
to recognise that only one item can differ between different function calls.


## Acknowledgements

This material was adapted from ... and modified by ...
