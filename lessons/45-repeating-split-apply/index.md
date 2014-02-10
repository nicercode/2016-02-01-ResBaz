---
layout: lesson
root: ../..
title: Repeating things -- The split--apply--combine pattern
tutor: Daniel Falster
---

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

## R's built-in library

R has a list of built-in functions for repeating things. In the previous section we learnt about for loops. Hopefully you saw how well-defined function helped everything run more smoothly. But for loops are quite limited. There's also a range of other functions allow you to apply some function
to a series of objects (eg. vectors, matrices, dataframes or files). This is called the apply family, and includes: `lapply`,  `sapply`,  `tapply`, `aggregate`, `mapply`, `apply`.

Each repeats a function or operation on a series of elements, but they
differ in the data types they accept and return.

What they all in common is that **order of iteration is not important**.  This is crucial. If each each iteration is independent, then you can cycle
through them in whatever order you like.

## The plyr package

While R's built in function do work, we're going to introduce you to another superior method for repeating things using the package [**plyr**](http://had.co.nz/plyr/). `plyr` is an R Package for Split-Apply-Combine workflows.  Its functional
programming model encourages writing reusable functions which can be called
across varied datasets and frees you from needing to manage for loop indices.

plyr has functions for operating on `lists`, `data.frames` and `arrays`.  Each
function performs:

1. A **split**ting operation
2. **Apply** a function on each split in turn.
3. Re**combine** output data as a single data object.

The functions are named based on which type of object they expect as input
([a]rray, [l]ist or [d]ata frame) and which type of data structure should be
returned as output.

This gives us 9 core functions **ply.  There are an additional three functions
which will only perform the split and apply steps, and not any combine step.
They're named by their input data type and represent null output by a `_` (see
table)

|INPUT\OUTPUT|Array|Data frame|List|Discarded|
|------------|:---:|:--------:|:--:|--------:|
|Array|aaply|adply|alply|a_ply|
|Data frame|daply|ddply|dlply|d_ply|
|list|laply|ldply|llply|l_ply|

### Understanding xxply

There are 3 key inputs to xxply:

* .data - data frame to be processed • .variables - splitting variables
* .fun - function called on each piece
* The first letter of the function name gives the input type and the second gives the output type.

### Examples


**TODO: incorporate examples from gapminder -> plyr.R to replace content below**

For an example, let's pull up gapminder dataset as before

```coffee
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
```

Now, what is we want to extra the list of countries by continent. So make a function to extract list of countries for a given continent

start: get total population size per continent
split, apply, combine

next: list of countries [introduction to list]



```coffee
get.countries <- function(cont,mydata){unique(mydata[mydata$continent==cont,]$country)}
````

Now try for one continent:

```
get.countries("Asia", data)
```

Now apply to other continents

```
get.countries("Africa", data)
get.countries("Americas", data)
...
```


Notice that there is only one thing varying per call -- the continent name. so now we're in a perfect position to call llply. First, let's make a variable `continents`. We have to pass in another argument, the `data` variable, but that stays the same.

So now we can apply it to all continents:

```coffee
countries <- dlply(data, .(continent), function(x) unique(x$country))

tot.pop <- ddply(data, .(continent), function(x) sum(x$pop))
tot.pop <- ddply(data, .(continent, year), function(x) sum(x$pop))
```

So what if we ant to extract the total population of each continent in 2007. Again, let's make a function that does it for a single continent

```coffee
get.population <- function(cont,year, mydata){sum(mydata[mydata$continent==cont & mydata$year==year,]$pop)}
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

extra step here to name output, also use sapply to simplify result into vector

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



# Feed data into model one-by-one returning models to a list of models.
models <- dlply(experiment, .(site), model)
```

Now we have a list of models, we want to write another plyr expression to
operate on that list of models and return a data frame of the slope, intercept
and R-squared values.

```{r}
coefs <- function(model) {
    c(coef(model), rsquare = summary(model)$r.squared)
}
ldply(models, coefs)
```


## Acknowledgements

This material was adapted from

- Karthik's intro
- Hadley's material
- other
... and modified by ...
