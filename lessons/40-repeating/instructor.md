---
layout: lesson
root: ../..
title: repeating instructor notes
tutor: Rich FitzJohn
---

Things to cue up:

* [split appply combine strategy](http://nicercode.github.io/2014-02-13-UNSW/lessons/40-repeating/splitapply.png)
* [ply functions](http://nicercode.github.io/2014-02-13-UNSW/lessons/40-repeating/full_apply_suite.png)

**Open Rstudio project for 40-repeating**

Copy to the etherpad:

# Exercises 1:  write a function that takes a dataframe as input and returns the number of countries

get.n.countries <- function(x) {

}


# Exercises 2:  write a function that takes a dataframe as input and returns the sum of the total population

get.total.pop <- function(x) {

}

# Then feed this into `ddply` to get the sum of the population in every continent


# Exercises 3: write a function that given a dataframe, returns a vector of unique country names in the dataset

get.countries <- function(x) {

}

# Then feed this into `dlply` to get a list containing the countries of each continent

countries <- dlply(....


######PLOTTING###############

# Exercise 4: write a function that given a data frame `x` fits a model to data, then try running it on main dataset

model <- function(x){
  lm(lifeExp ~ log10(gdpPercap), data=x)
}

