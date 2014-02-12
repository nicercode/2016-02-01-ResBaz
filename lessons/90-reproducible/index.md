---
layout: lesson
root: ../..
title: Reproducible research
tutor: Daniel Falster, with Diego Barneche
---

## Introduction

We're now in the home stretch of the workshop - congratulations! Up to this
point, we've talked about how to make your code efficient (good programming
practice), accurate (testing), and maintainable (modularization + version
control). Now we're going to talk about a final and very important concept
known as reproducibility.

In case you hadn't already noticed, science has a growing credibility problem, mostly due to inability of researchers to reproduce published results.

* Title page from economist: [Science goes wrong](http://www.economist.com/news/leaders/21588069-scientific-research-has-changed-world-now-it-needs-change-itself-how-science-goes-wrong)
	* Results cannot be replicated
	* Cultural issues about publishing, also way we treat code and data
* This is important
	- Want our science to be high quality
	- Public deserves best quality
	- You could end up in court, and or responsible for people's (or other organisms) lives
	- [Scientists nightmare - retractions](http://www.sciencemag.org/content/314/5807/1856.summary)
* Journals and reviewers starting to focus on reproducibility
	- Nature released [special issue](http://www.nature.com/nature/focus/reproducibility/index.html), also updated their policy [about methods and data]( http://doi.org/10.1038/496398a) so that data, code now required.
	- At least one journal now requires code for review
* Actually, most important reason if for you. **Crisis also starts in own own computers**:
	- Are you sure your analysis does what you think it does?
	- Can we understand our own code when we return to it after years?
	- Could you show me who contributed what to a project?
	- Can you identify where a bug was introduced and what analyses it affected?
	- Can you reproduce any of the key results from your research in less than a few minutes?

### Goals of reproducible research

For our purposes, we can summarize the goal of reproducibility in two related
ways, one technical and one colloquial.

In a technical sense, your goal is to __have a complete chain of custody (ie,
provenance) from your raw data to your finished results and figures__. That is,
you should _always_ be able to figure out precisely what data and what code
were used to generate what result - there should be no "missing links". If you
have ever had the experience of coming across a great figure that you made
months ago and having no idea how in the world you made it, then you understand
why provenance is important. Or, worse, if you've ever been unable to recreate
the results that you once showed on a poster or (gasp) published in a
paper...

In a colloquial sense, I should be able to sneak into your lab late at night,
delete everything except for your raw data and your code, and __you should be
able to run a single command to regenerate EVERYTHING, including all of your
results, tables, and figures in their final, polished form__. Think of this as
the "push button" workflow. This is your ultimate organizational goal as a
computational scientist. Importantly, note that this rules out the idea of
manual intervention at any step along the way - no tinkering with figure axes
in a pop-up window, no deleting columns from tables, no copying data from one
folder to another, etc. All of that needs to be fully automated.

As an added bonus, if you couple this with a version control system that tracks
changes over time to your raw data and your code, you will be able to instantly
recreate your results from any stage in your research (the lab presentation
version, the dissertation version, the manuscript version, the Nobel Prize
committee version, etc.). Wouldn't that be nice?

## Pulling it all together

So let's look at how the things we've learnt help reproducibility. Throughout the bootcamp we've been giving you all the elements of a reproducible work flow.

**Qu: What are these elements**

1.	Created a clear and useful directory structure for our project.
2.	Set up (and used) Git to track our changes.
3.	Added the raw data to our project.
4.	Write our code to perform the analysis, including tests.
5.	A master script to reproduce our results

The only one your missing now is the last one. We're going to show you two ways to bind all your work together.

## Exporting figures and tables

The first involves simply printing output to file. This works well for final versions of papers. You want a nice short readable analysis script and some functions that produce figures. By default R produces plots and tables in the output window, so our goal is to save these to file.

## Tables

Saving tables is relatively straight forward using `write.csv`.

Let's say we have a table of values from

```coffee
library(plyr)
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
# For each year, fit linear model to life expectancy vs gdp by continent
fitted.linear.model <- dlply(data, .(continent, year), function(x)lm(lifeExp ~ log10(gdpPercap), data=x))
model.summary <- function(x){
  data.frame(r2=summary(x)$r.squared, n=length(x$model$lifeExp), a=coef(x)[[1]], b=coef(x)[[2]])}
model.data <- ldply(fitted.linear.model,model.summary)
```

Now we just want to write this table to file:

```coffee
dir.create("output")
write.csv(model.data, file="output/table1.csv")
```

This is good, but there's a couple of problems:

- row numbers usually not wanted
- quotes are ugly
- too many decimal places.

So here's a better version:

```coffee
write.csv(format(model.data, digits=2, trim=TRUE), file="output/table1.csv", row.names=FALSE, quote=FALSE)
```

### Plots

One way of plotting to a file is to open a plotting device (such
as `pdf` or `png`) run a series of commands that generate plotting
output, and then close the device with `dev.off()`, e.g.

```
pdf("my-plot.pdf", width=6, height=4)
  # ...my figure here
dev.off()
```


Hopefully your figure code is stored as a function, so that you can type

```
fig.trend() # generates figure
```

to make your figure, or

```
source("R/figures.R") # refresh file that defines fig.trend
fig.trend()
```

Now you can type

```
pdf("figures/trend.pdf", width=6, height=8)
fig.trend()
dev.off()
```

However, this still gets a bit unweildly when you have a large number
of figures to make (especially for talks where you might make 20 or 30
figures).

```
pdf("figures/trend.pdf", width=6, height=4)
fig.trend()
dev.off()

pdf("figures/other.pdf", width=6, height=4)
fig.other()
dev.off()
```

A better approach [proposed by Rich](http://nicercode.github.io/blog/2013-07-09-figure-functions/) is to use a little function called `to.pdf`:

```
to.pdf <- function(expr, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  pdf(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}
```

Which can be used like so:


```
to.pdf(fig.trend(), "figures/trend.pdf", width=6, height=4)
to.pdf(fig.other(), "figures/other.pdf", width=6, height=4)
```

A couple of nice things about this approach:

* It becomes much easier to read and compare the parameters to the
  plotting device (width, height, etc).
* We're reduced things from 6 repetitive lines to 2 that capture our
  intent better.
* The to.pdf function demands that you put the code for your figure in a function.
* Using functions, rather than statements in the global environment,
  discourages dependency on global variables.  This in turn helps
  identify reusable chunks of code.
* Arguments are all passed to `pdf` via `...`, so we don't need to
  duplicate `pdf`'s argument list in our function.
* The `on.exit` call ensures that the device is always closed, even if
  the figure function fails.

For talks, I often build up figures piece-by-piece.  This can be done
by adding an option to your function (for a two-part figure)

```
fig.progressive <- function(with.trend=FALSE) {
  set.seed(10)
  x <- runif(100)
  y <- rnorm(100, x)
  par(mar=c(4.1, 4.1, .5, .5))
  plot(y ~ x, las=1)
  if ( with.trend ) {
    fit <- lm(y ~ x)
    abline(fit, col="red")
    legend("topleft", c("Data", "Trend"),
           pch=c(1, NA), lty=c(NA, 1), col=c("black", "red"), bty="n")
  }
}
```

Now -- if run with as

```
fig.progressive(FALSE)
```

just the data are plotted, and if run as


```
fig.progressive(TRUE)
```

the trend line and legend are included.  Then with the `to.pdf`
function, we can do:


```
to.pdf(fig.progressive(TRUE),  "figures/progressive-1.pdf", width=6, height=4)
to.pdf(fig.progressive(FALSE), "figures/progressive-2.pdf", width=6, height=4)
```

which will generate the two figures. The general idea can be expanded to more devices, such as png (see this [blog post](http://nicercode.github.io/blog/2013-07-09-figure-functions/) for details).


## Reproducible reports with knitr

Another approach for making reproducible outputs is to combine plots, tables, code and a description of content in a single document.

Diego....

## My ideal paper

* All analyses and data in git repository
	- open on github (some journal now host git repos)
* Publication version of code archived with paper as supplementary material
* Raw data also available with article, hosted in open repository, e.g. [DRYAD](datadryad.org).
* Code modified to run directly from online data repo
	- anyone (including me) can rerun my analyses at any time.
* Anyone can build on your research.

The workflow that we're following here is just a suggestion.
Organizing code and data is an art, and a room of 100 scientists will give you
101 opinions about how to do it best. Consider this material a useful place to get started, and don't hesitate to tinker and branch out as you get a better feel for this process.

**Qu: What are some of barriers to achieving this workflow?**

**Qu: What are the additional benefits of this workflow**

- ensures data is not lost( [Scientists losing data at a rapid rate. Nature.]( http://doi.org/10.1038/nature.2013.14416)
- speeds up science by giving someone to build on [radical openness](http://vimeo.com/38260970)

## Examples of reproducible research we know of

* The code to create the supplementary figures in [this paper](http://dx.doi.org/10.1111/j.2041-210X.2012.00234.x) are 
[here](https://github.com/richfitz/diversitree/blob/master/pub/example/primates.Rnw) -- the compiled version is [here](http://onlinelibrary.wiley.com/store/10.1111/j.2041-210X.2012.00234.x/asset/supinfo/mee3234_sm_diversitree-suppl.pdf?v=1&s=0e50af3b4e692c5e9f87abdcb9a2346de1463842) (starts on p 15).
* This [supporting material](http://rspb.royalsocietypublishing.org/content/281/1778/20132570/suppl/DC1) is completely reproducible.
* This [paper](http://www.g3journal.org/content/early/2013/10/30/g3.113.008565/suppl/DC1) is completely reproducible

## More reading

* Victoria Stodden has written extensively about the
idea of reproducibility in scientific software - you may want to look up [some
of her papers](http://www.stanford.edu/~vcs/Papers.html) for reference.
* William Noble's paper on [Organizing Computational Biology Projects](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000424)
* Greg Wilson's paper on [Best Practices for Scientific Computing](http://doi.org/10.1371/journal.pbio.1001745)


## Acknowledgements: This material was adapted from ... and modified by ...

Benefited from points raised in discussion [across swc community](https://github.com/swcarpentry/bc/issues/199)

