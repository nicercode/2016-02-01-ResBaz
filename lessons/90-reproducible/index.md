---
layout: lesson
root: ../..
title: Reproducible research
tutor: Daniel Falster, with Diego Barneche
---

**Materials**: If you have not already done so, please [download the lesson materials for this bootcamp](https://github.com/nicercode/2014-02-18-UTS/raw/gh-pages/data/lessons.zip), unzip, then go to the directory `reproducible`, and open (double click) on the file `reproducible.Rproj` to open Rstudio.

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
source("R/functions.R")
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)

# For each year, fit linear model to life expectancy vs gdp by continent
model.data <- ddply(data, .(continent,year), fit.model, x="lifeExp", y="gdpPercap")
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


Hopefully your figure code is stored as a function, so that you can type something like

```
library(plyr)
source("R/functions.R")
data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
data.1982 <- data[data$year == 1982,]
myplot(data.1982,"gdpPercap","lifeExp", main =1982)
```

to make your figure.  Now you can type

```
pdf("output/my-plot.pdf", width=6, height=4)
myplot(data.1982,"gdpPercap","lifeExp", main =1982)
dev.off()
```

However, this still gets a bit unweildly when you have a large number
of figures to make (especially for talks where you might make 20 or 30
figures).

A better approach [proposed by Rich](http://nicercode.github.io/blog/2013-07-09-figure-functions/) is to use a little function called `to.pdf`:

```coffee
to.pdf <- function(expr, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  pdf(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}
```

Which can be used like so:


```coffee
to.pdf(myplot(data.1982,"gdpPercap","lifeExp", main=1982), "output/1982.pdf", width=6, height=4)
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

```coffee
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

```coffee
fig.progressive(FALSE)
```

just the data are plotted, and if run as


```coffee
fig.progressive(TRUE)
```

the trend line and legend are included.  Then with the `to.pdf`
function, we can do:


```coffee
to.pdf(fig.progressive(TRUE),  "output/progressive-1.pdf", width=6, height=4)
to.pdf(fig.progressive(FALSE), "output/progressive-2.pdf", width=6, height=4)
```

which will generate the two figures. The general idea can be expanded to more devices, such as png (see this [blog post](http://nicercode.github.io/blog/2013-07-09-figure-functions/) for details).

We can use a similar approach to export figures in png format

```coffee

to.dev <- function(expr, dev, filename, ..., verbose=TRUE) {
  if ( verbose )
    cat(sprintf("Creating %s\n", filename))
  dev(filename, ...)
  on.exit(dev.off())
  eval.parent(substitute(expr))
}

to.dev(myplot(data.1982, "gdpPercap","lifeExp", main=1982), png, "output/1982.png", width=600, height=400)

```


## Reproducible reports with knitr

Another approach for making reproducible outputs is to combine plots, tables, code and a description of content in a single document.

The classical ([sweave](http://www.stat.uni-muenchen.de/~leisch/Sweave/)) has been progressively replaced by an R package called `knitr`, which uses a language called [Markdown][id1]. `knitr` can be used for many nice features, from [reports][id2] to full [presentations][id3]. It can be coded in a specific language called [R markdown][id4]. For example, this [report][id2] that we provided to you derived from this [Rmd][id5] file.
You can find out more about how `knitr` works ([here](http://yihui.name/knitr/)) and ([here](https://www.rstudio.com/ide/docs/authoring/overview)).

## An ideal paper

Here is what my ideal paper would look like

* All analyses and data in git repository
	- open on github (some journal now host git repos)
* Publication version of code archived with paper as supplementary material
* Raw data also available with article, hosted in open repository, e.g. [DRYAD](datadryad.org).
* Code modified to run directly from online data repo so  anyone (including you) can rerun analyses at any time.
* key analyses embedded within a knitr script which produces a nice document for supplementary material.
* Anyone can build on your research with a few clicks of their mouse.

The work flow that we're following here is just a suggestion.
Organizing code and data is an art, and a room of 100 scientists will give you
101 opinions about how to do it best. Consider this material a useful place to get started, and don't hesitate to tinker and branch out as you get a better feel for this process.

**Some good examples of reproducible research we know of**

* The code to create the supplementary figures in [this paper](http://dx.doi.org/10.1111/j.2041-210X.2012.00234.x) are
[here](https://github.com/richfitz/diversitree/blob/master/pub/example/primates.Rnw) -- the compiled version is [here](http://onlinelibrary.wiley.com/store/10.1111/j.2041-210X.2012.00234.x/asset/supinfo/mee3234_sm_diversitree-suppl.pdf?v=1&s=0e50af3b4e692c5e9f87abdcb9a2346de1463842) (starts on p 15).
* This [supporting material](http://rspb.royalsocietypublishing.org/content/281/1778/20132570/suppl/DC1) is completely reproducible.
* This [paper](http://www.g3journal.org/content/early/2013/10/30/g3.113.008565/suppl/DC1) is completely reproducible

**Qu: What are some of the additional benefits of this workflow**

- ensures data is not lost( [Scientists losing data at a rapid rate. Nature.]( http://doi.org/10.1038/nature.2013.14416)
- speeds up science by giving everyone [something to build on](http://vimeo.com/38260970)

**Qu: What are some of barriers to achieving this workflow?**


## More reading

* Victoria Stodden has written extensively about the
idea of reproducibility in scientific software - you may want to look up [some
of her papers](http://www.stanford.edu/~vcs/Papers.html) for reference.
* William Noble's paper on [Organizing Computational Biology Projects](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000424)
* Greg Wilson's paper on [Best Practices for Scientific Computing](http://doi.org/10.1371/journal.pbio.1001745)


## Acknowledgements

This material presented here was adapted from swc by Daniel Falster, incorporating new material from Rich FitzJohn and also views presented by a wide range of people across the twittersphere and [within the swc community](https://github.com/swcarpentry/bc/issues/199)

[id1]: http://en.wikipedia.org/wiki/Markdown "Markdown in Wikipedia"
[id2]: http://nicercode.github.io/2014-02-13-UNSW/lessons/90-reproducible/knitr "UNSW/UTS example of html knitr report"
[id3]: http://rpubs.com/recology_/rresources "Scott Chamberlain online presentation"
[id4]: http://www.rstudio.com/ide/docs/authoring/using_markdown "RStudio material for R Markdown"
[id5]: https://github.com/nicercode/2014-02-13-UNSW/blob/gh-pages/lessons/90-reproducible/knitr.Rmd "UNSW/UTS example of original Rmd file used to generate knitr reports"
