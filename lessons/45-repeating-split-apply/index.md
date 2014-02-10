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

## Split, apply, combine with the Dplyr package

  - group_by, arrange, summarise, mutate


## Acknowledgements

This material was adapted from ... and modified by ...
