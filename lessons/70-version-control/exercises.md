---
layout: lesson
root: ../..
title: Exercises
tutor: Rich FitzJohn
---

# Exercises for the git bit

The git section is odd because there is lots of talking; this was the same when Greg ran SWC at MQ, too.  I don't think there is any silver bullet.  There are some exercises that we can run through within basics and branching, but I'd like to get them here in a more concise form so that it's easier to know where we are going.

## Creating a repository

* Open up a terminal at the current directory (we've been doing projects by this point, so that should be fairly easy: we can at worst do `getwd()` and cd into that).
* type `git init`

## Adding existing work

* Add the data file: `git add data/gapminder-FiveYearData.csv`
* Commit the file: `git commit -m "Adding data"`

* Add the script files

## Selecting what to ignore

## The commit cycle

Have students edit their scripts.  They can add a new analysis, a new comment, whatever.  Doesn't really matter.

* Look at changes with `git status`
* Look at changes with `git diff`
* Commit changes with `git add`/`git commit`

## Looking at the log

* `git log`
* `git diff`
* `git whatchanged`

## Continuing

At this point, some of the way forward is to use the material in swc-git; that covers different ways of using diff, etc.

