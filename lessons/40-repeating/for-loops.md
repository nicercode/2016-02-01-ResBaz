---
layout: lesson
root: ../..
title: Repeating things -- for loops
tutor: Rich FitzJohn
---

When you mention looping, many people immediately reach for `for`. Perhaps
that's because they are already familiar with these other languages,
like basic, python, perl, C, C++ or matlab. While `for` is definitely the most
flexible of the looping options, we suggest you avoid it wherever you can, for
the following two reasons:

1. It is not very expressive, i.e. takes a lot of code to do what you want.
2. It permits you to write horrible code, like [this example from my earlier
   work](ugly)

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

Write a function which makes a plot.  use function from previous section:

```
relative_growth_rate <- function(t, x){
  if(any(sort(t) != t))
    stop("time must be sorted")
  c(diff(x)/diff(t), NA) / x
}
```


Now make a plot

```coffee
plot.pop.growth <- function(continent, data){
  plot(c(1950, 2010),c(1,1), ylim=c(-0.05,0.1), xlab="year", ylab="Growth rate", lty="dashed", type='l', main =continent, las=1)
  for(thiscountry in unique(data[data$continent ==continent,]$country)){
    data.sub <- filter(data,country==thiscountry)
    points(data.sub$year, relative_growth_rate(data.sub$year,data.sub$pop), type='l')
  }
}
```



Can now apply this to different continents

```coffee
plot.pop.growth("Asia", data)
plot.pop.growth("Oceania", data)
```

And finally embed in loop

```coffee
for( cont in unique(data$continent))
  plot.pop.growth(cont, data)
```

Now you have a go, see if you can modify function above, to instead of plotting population growth, plots growth in gdp.

**Notice how little of code we have to change?**

Suggests two different functions wasteful, so why don't we generalise to take any variable

```coffee
plot.growth <- function(continent, data, var){
  plot(c(1950, 2010),c(1,1), ylim=c(-0.05,0.1), xlab="year", ylab=paste("Growth rate,", var), lty="dashed", type='l', main =continent, las=1)
  for(thiscountry in unique(data[data$continent ==continent,]$country)){
    data.sub <- filter(data,country==thiscountry)
    points(data.sub[["year"]], relative_growth_rate(data.sub[["year"]],data.sub[[var]]), type='l')
  }
}
```

```coffee
for( cont in unique(data$continent))
  plot.growth(cont, data, "pop")
```

```coffee
for( cont in unique(data$continent))
  plot.growth(cont, data, "lifeExp")
```

**Exercise:** Now try making that plot of gdppercap vs lifeExp from earlier, plot for different years by embedding within a function

..........

## Extras: How to debug a function

Demonstrate how to use `browser()` function, explain about scope

## Acknowledgements

This material was adapted from ... and modified by ...
