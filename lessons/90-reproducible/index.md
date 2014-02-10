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
5.	A magic script to reproduce our results

Look at last one, show you two ways to bind all your work together

## Exporting figures and tables

to.pdf function ?

This works well for final versions of papers.

## Reproducible reports with knitr

Diego....


Push the button and watch the magic.

Slides....

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

## More reading

* Victoria Stodden has written extensively about the
idea of reproducibility in scientific software - you may want to look up [some
of her papers](http://www.stanford.edu/~vcs/Papers.html) for reference.
* William Noble's paper on [Organizing Computational Biology Projects](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000424)
* Greg Wilson's paper on [Best Practices for Scientific Computing](http://doi.org/10.1371/journal.pbio.1001745)


## Acknowledgements: This material was adapted from ... and modified by ...

Benefited from points raised in discussion [across swc community](https://github.com/swcarpentry/bc/issues/199)

