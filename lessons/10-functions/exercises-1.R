## Part 1: Getting started with functions -- the complete basics.

## Simple function
f <- function(x)
  x

## Slightly less simple function
double <- function(x)
  2 * x

## Argument names are local
z <- 10
double(z)
# --> 20

## Scoping
x <- 1
double(z)
# --> 20 (x is ignored)
x
# --> 1 (x was unchanged)

## Part 2: Defining simple functions

## I used these in the intro to R course and people could see what was
## going on fairly quickly.  These might be useful before getting into
## the data, or for computing it.  The nice thing about this is we can
## have people compute the skew for (say) population and then we'll
## work out if they've got it correct.
dat <- read.csv("data/gapminder-FiveYearData.csv",
                stringsAsFactors=FALSE)

## variance
var.sample <- function(x) {
  n <- length(x)
  sum(x^2 - mean(x)^2) / (n - 1)
}

## skew

## Skew defined as (1/(n-2) * sum((x_i - mean(x))^3) / var(x)^(3/2))

## Have people compute skew on one of the columns of the data.

## We could look at relative growth rate here instead or as well.
## Function definition:
relative.growth.rate <- function(t, x) {
  if (is.unsorted(t))
    stop("'t' must be sorted")
  c(diff(x) / diff(t), NA) / x
}

## (why are we padding NA at the end?  It would be just as valid at
## the beginning, no?  Or is this standard in some field?  Should we
## be returning the midpoint of each interval as new times instead?)
## Off-by-one errors might be good to introduce or they might be
## confusing.
