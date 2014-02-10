---
layout: lesson
root: ../..
title: Repeating things -- for loops
tutor: Daniel Falster
---

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
