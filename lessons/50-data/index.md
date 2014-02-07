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

13:45 - 14:15

## Don't repeat yourself

Previously we looked at how you can [use functions to simplify your
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
get_countries <- function(cont,mydata){unique(mydata[mydata$continent==cont,]$country)}
````

Now try for one continent:

```
get_countries("Aisa", data)
```

Now we had better test it

```coffee
library(testthat)
expect_that(get_countries("Oceania", data), equals(c("Australia","New Zealand")))
```

Now apply to other continents

```
get_countries("Africa", data)
get_countries("Americas", data)
...
```

Notice that there is only one thing varying per call -- the continent name. so now we're in a perfect position to call lapply. First, let's make a variable `continents`. We have to pass in another argument, the `data` variable, but that stays the same.

```coffee
continents <- unique(data$continent)
```
So now we can apply it to all continents:

```coffee
countries <- lapply(continents, get_countries, data=data)
names(countries) <- continents
```

So what if we ant to extract the total population of each continent in 2007. Again, let's make a function that does it for a single continent

```coffee
get_population <- function(cont,year, mydata){sum(mydata[mydata$continent==cont & mydata$year==year,]$pop)}
```

Now we had better test it

```coffee
Asia2007 <- subset(data, continent=="Asia" & year ==2007)
expect_that(get_population("Asia", 2007, data), equals(sum(Asia2007$pop)))
```

Finally, apply to entire dataset

```coffee
populations <- sapply(continents, get_population, data=data, year=2007)
```

**Your challenge**: Now find number of countries in each continent

```coffee
get_n_countries <- function(cont,data){length(unique(data[data$continent==cont,]$country))}
sapply(continents, get_n_countries, data=data)
```

OR you could use earlier result and feed that into lapply

```coffee
lapply(countries, length)
```

extra step here to name output, also use sapply to simplify reasult into vetcor

```coffee
nCountries <- data.frame(continents, ncountries = sapply(countries, length))
```

This last example highlights a strneght of lapply, it's great for building analysis pipelines, where you want to repeat a series of steps on a large number of similar objects.  The way to do this is to
have a series of lapply statements, with the output of one providing the input to another.

```coffee
first.step <- lapply(X, first.function)
second.step <- lapply(first.step, next.function)
```

The challenge is to identify the parts of your analysis that stay the same and
those that differ for each call of the function. The trick to using `lapply` is
to recognise that only one item can differ between different function calls.

## For loops

When you mention looping, many people immediately reach for `for`. Perhaps
that's because they are already familiar with these other languages,
like basic, python, perl, C, C++ or matlab. While `for` is definitely the most
flexible of the looping options, we suggest you avoid it wherever you can, for
the following two reasons:

1. It is not very expressive, i.e. takes a lot of code to do what you want.
2. It permits you to write horrible code, like this example from my earlier
   work:


```coffee
  for(n in 1:n.spp)
    {
    Ind = unique(Raw[Raw$SPP==as.character(sp.list$SPP[n]), "INDIV"]);
    I =    length(Ind);
    par(mfrow=c(I,1), oma=c(5,5,5, 2), mar=c(3, 0, 0, 0));
    for(i in 1:I)
        {
        Dat = subset(Raw, Raw$SPP==as.character(sp.list$SPP[n]) & Raw$INDIV==Ind[i])
        Y_ax =seq(0, 35, 10); Y_ax2=seq(0, 35, 5);
        X_ax =seq(0, max(Dat$LL), 0.2); X_ax2 =seq(0, max(Dat$LL), 0.1);
        plot(1:2, 1:2, type="n",log="", axes=F,ann=F, xlim = c(-0.05, max(Dat$LL)+0.05), ylim=c(min(Y_ax), max(Y_ax)), xaxs="i", yaxs="i", las=1)
        axis(2, at=Y_ax, labels=Y_ax, las=1, tck=0.030, cex.axis=0.8, adj = 0.5)
        axis(4, at=Y_ax, labels=F,  tck=0.03)

        X<-Dat$AGE;  Xout<-data.frame(X = c(0,Dat$LL[1]))

        Y<-Dat$S2AV_L;
        points(X,Y,type="p", pch=Fig$Symb[2], cex=1.3, col= Fig$Cols[2]);
        R<-lm( Y~ X); points(Xout$X, predict(R, Xout), type="l", col= Fig$Cols[2], lty = "dotted")

        legend("topright", legend = paste("indiv = ",Ind[i]), bty= "n")
       }
   mtext(expression(paste("Intercepted light (mol ", m^{-2},d^{-1},")")), side = 2, line = 3, outer = T, adj = 0.5, cex =1.2)
   mtext(expression(paste("Leaf age (yrs)")), side = 1, line = 0.2, outer = T, adj = 0.5, cex =1.2)
   mtext(as.character(sp.list$Species[n]), side = 3, line = 2, outer = T, adj = 0.5, cex =1.5)
   }
rm(R, Ind, I, i, X, X_ax, X_ax2, Y_ax, Y_ax2, Y, Xout, Dat)
```

The main problems with this code are that

- it is hard to read
- all the variables are stored in the global scope, which is dangerous.

All it's doing is making a plot! Compare that to something like this

```coffee
for (i in unique(Raw$SPP))
  makePlot(i, data = Raw)
```

That's much nicer! It's obvious what the loop does, and no new variables are
created. Of course, for the code to work, we need to define the function


```coffee
makePlot <- function(species, data){
  ... #do stuff
}
```

which actually makes our plot, but having all that detail off in a
function has many benefits:

- Most of all it makes your code more readable
- Also more reliable, because cleans up work space --> less chance of mutability bugs.

### Examples

Write a function which makes a plot.

```coffee
plot_pop_growth <- function(continent,  data){
  plot(c(1950, 2010),c(1,1), ylim=c(0.5,4), xlab="year", ylab="Population size", lty="dashed", type='l', main =continent, las=1)
  countries <- unique(data[data$continent ==continent,]$country)
  popSize <- lapply(countries, function(x) data[data$country == x, c("year", "pop")])
  names(popSize) <- countries
  for(country in countries)
    points(popSize[[country]]$year, popSize[[country]]$pop/popSize[[country]]$pop[1], type='l')
}
```

Can now apply this to different continents

```coffee
plot_pop_growth("Asia", data)
plot_pop_growth("Oceania", data)
```

And finally embed in loop

```coffee
for( cont in unique(data$continent))
  plot_pop_growth(cont, data)
```

Now you have a go, see if you can modify function above, to instead of plotting population growth, plots growth in gdp.

**Notice how little of code we have to change?**

Suggests two different functions wasteful, so why don't we generalise to take any variable

```coffee
plot_growth <- function(continent, data, var="pop"){
  plot(c(1950, 2010),c(1,1), ylim=c(0.5,4), xlab="year", ylab=var, lty="dashed", type='l', main =continent, las=1)
  countries <- unique(data[data$continent ==continent,]$country)
  popSize <- lapply(countries, function(x) data[data$country == x, c("year", var)])
  names(popSize) <- countries
  for(country in countries)
    points(popSize[[country]][["year"]], popSize[[country]][[var]]/popSize[[country]][[var]][1], type='l')
}
```

```coffee
for( cont in unique(data$continent))
  plot_pop_growth(cont, data, "pop")
```

## The split--apply--combine pattern

By now you may have recognised that most operations that involve
looping are instances of the *split-apply-combine* strategy (this term
and idea comes from the prolific [Hadley Wickham](http://had.co.nz/),
who coined the term in [this
paper](http://vita.had.co.nz/papers/plyr.html)).  You start with a
bunch of data.  Then you then **Split** it up into many smaller
datasets, **Apply** a function to each piece, and finally **Combine**
the results back together.

![Split apply combine](https://github.com/swcarpentry/2013-10-09-canberra/raw/master/03-data-manipulation/splitapply.png)

Some data arrives already in its pieces - e.g. output files from from
a leaf scanner or temperature machine. Your job is then to analyse
each bit, and put them together into a larger data set.

Sometimes the combine phase means making a new data frame, other times it might
mean something more abstract, like combining a bunch of plots in a report.

Either way, the challenge for you is to identify the pieces that remain the same between different runs of your function, then structure your analysis around that.

## Split, apply, combine with the Dplyr package

	- group_by, arrange, summarise, mutate

## Extras: How to debug a function

Demonstrate how to use `browser()` function, explain about scope

4. Interlude: a bit about plotting
	- code always ugly.
	- use functions to make do nice figures
	- Example: blankplot, label, world map, to.pdf
	- Showcase: nice plots we have made

## Wrap up - Principles of writing nice code (in R)

Conclusion to day 1, wrapping up core messages about code development

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

### Becoming more productive

Functions enable easy reuse within a project, helping you not to
repeat yourself.  If you see blocks of similar lines of code through
your project, those are usually candidates for being moved into
functions.

If your calculations are performed through a series of functions, then
the project becomes more modular and easier to change.  This is
especially the case for which a particular input always gives a
particular output.


## Acknowledgements

This material was adapted from ... and modified by ...

