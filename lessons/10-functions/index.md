---
layout: lesson
root: ../..
title: Writing functions in R
tutor: Daniel Falster
---

<!-- # Goals

1. Understand R's function syntax (argument lists, defaults, return
	 semantics) and scoping rules.
2. Start to writing their own functions
 -->

Abstracting your code into many small functions is key for writing
nice R code. In our experience, biologists are initially reluctant to
use functions in their code. Where people do use functions, they don't
use them enough, or try to make their functions do too much at once.

R has many built in functions, and you can access many more by
installing new packages. So there's no-doubt you already *use*
functions. But what about writing your own?

Writing functions is simple. Paste the following code into your console

```coffee
f <- function(x)
  x
```

This function takes `x` as an argument and returns `x` as a value.

The "body" of a function can be wrapped in curly brackets:

```
f <- function(x) {
  x
}
```

or these can be omitted for functions that are just one line long (this is a matter of taste, though there are wars between people who believe that the curly brackets belong in different places).

The body of the function can contain any valid R expression:

```
double <- function(x) {
  2 * x
}
```

Whatever is used as an *argument* to this  function becomes `x` within the body of the function.  So

```
z <- 10
double(z)
```

returns 20.  It does not matter at all if an `x` exists in the global environment

```
z <- 10
x <- 1
double(z) # 20
x         # still 1
```

This is one of the main uses of functions: they isolate different variables within your program.  This makes it easier to think about what you are doing.

The procedure for using functions in your work involves three key steps:

1. Define the function,
2. Load the function into the R session,
3. Use the function.

## (see exercises-1.R here for more material)

```
dat <- read.csv("data/gapminder-FiveYearData.csv",
                stringsAsFactors=FALSE)
```

## Defining a function (more theory)

```coffee
function.name <- function(arg1, arg2, arg3) {
  newVar <- sin(arg1) + sin(arg2)  # do Some Useful Stuff
  newVar / arg3   # return value
}
```

**function.name**: is the function's name. This can be any valid
variable name, but you should avoid using names that are used
elsewhere in R, such as `dir`, `function`, `plot`, etc.

**arg1, arg2, arg3**: these are the `arguments` of the function, also
called `formals`. You can write a function with any number of
arguments. These can be any R object: numbers, strings, arrays, data
frames, of even pointers to other functions; anything that is needed
for the function.name function to run.

**Function body**: The function code between the within the `{}`
brackets is run every time the function is called. This code might be
very long or very short.  Ideally functions are short and do just one
thing -- problems are rarely too small to benefit from some
abstraction.  Sometimes a large function is unavoidable, but usually
these can be in turn constructed from a bunch of small functions.
More on that below.

**Return value**: The last line of the code is the value that will be
`returned` by the function. It is not necessary that a function return
anything, for example a function that makes a plot might not return
anything, whereas a function that does a mathematical operation might
return a number, or a list.


**Some functions come with default arguments**

Some arguments have default values specified, such as in the example below. Arguments without a default generally need to have a value supplied
for the function to run. You do not need to provide a value for those
arguments with a default, as the function will use the default value.

```coffee
add.numbers <- function(a, b=2) {
  a + b
}
```

**R functions are objects just like anything else**

* can be deleted or written over
* Can be passed as arguments to other functions or returned
  from other functions.

```coffee
add.functions <- function(x, f1, f2) {
    f1(x) + f2(x)
}
```

# (see exercises-2.R here)

**Qu: Do we need to know how a function works to use it?**

No, difference between *what* and *implementation*.

But you do need to know that function is working as it should.

**A little more on the ellipsis argument**

The ellipsis argument `...` is a powerful way of passing an arbitrary
number of functions to a lower level function.

Suppose want to pass some other option for reading file in function above, e.g. stringsAsFactors=FALSE, adding `...` to argument list makes this possible

```
url <- "https://raw.github.com/nicercode/gapminder/master/data/gapminder-2007.csv"
data1 <- retrieve_data_from_url(url, stringsAsFactors=FALSE)
data2 <- retrieve_data_from_url(url, stringsAsFactors=TRUE)
```

## Workflow for developing functions

1. Identify what you want to achieve
2. Code it up in global environment
3. Move into function
4. Debug

**Qu: what is something we want to do with this dataset?**
Have a look at variables.

Return data of year vs population growth for a given country.

First develop in main window

```coffee
dat <- read.csv("data/gapminder-FiveYearData.csv",
                stringsAsFactors=FALSE)

i <- dat$country == "Australia"

country <- "Australia"
i <- dat$country == country
dat.au <- dat[i,]
dat.au <- dat[i,c("year", "pop")]
```

Now define as function

```coffee
get.population <- function(data, country) {
  data[data$country == country, c("year", "pop")]
}
```

**Qu: Is this useful given it is only a one line function?**

Yes: More readable, less code when using repeatedly --> Don't Repeat Yourself

No function is too small.
=======
Yes: Your program becomes defined around the "what" and not the "how"

```
get.population <- function(data, country) {
  dbAccess(data, paste("SELECT * from tblData WHERE country ==", country)
}
```

**Qu: do we need to include data argument?**

Try without - does it still work?

Discuss scope.

## What makes for a good function?

**It's short**
<blockquote class="twitter-tweet"><p>If you've written a function whose body is 2,996 lines of code, you're doing it wrong.</p>&mdash; M Butcher (@technosophos) <a href="https://twitter.com/technosophos/status/322392537983746049">April 11, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

**Performs a single operation**

<blockquote class="twitter-tweet"><p>The reason for writing a function is not to reuse its code, but to name the operation it performs.</p>&mdash; Tim Ottinger (@tottinge) <a href="https://twitter.com/tottinge/status/293776089099153408">January 22, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

**Has an informative name and argument names**

<blockquote class="twitter-tweet"><p>"The name of a variable, function, or class, should answer all the big questions." - Uncle Bob Martin, Clean Code</p>&mdash; Gustavo Rod. Baldera (@gbaldera) <a href="https://twitter.com/gbaldera/status/327063173721100288">April 24, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Exercises

Using gap minder data set, make functions that

1. Calculate total GDP for a given year and location --> use this to make a new variable giving total GDP per country
2. Return a time series of year, life Expectancy, total GDP, population size for a given country
3. Returns average life expectancy for entire population within a given continent

## Concluding thoughts

This material written for coders with limited experience.  Program
design is a bigger topic than could be covered in a whole course, and we
haven't even begun to scratch the surface here.  Using functions is
just one tool in ensuring that your code will be easy for you to read
in future, but it is an essential tool.

<blockquote class="twitter-tweet"><p>The more I write code, the more abstract it gets. And with more abstractions, the apps are easier to maintain. Been working for years...</p>&mdash; Justin Kimbrell (@justin_kimbrell) <a href="https://twitter.com/justin_kimbrell/status/329054399425019906">April 30, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

## Further reading

If you want to read more about function syntax, check out the following:

- The [official R intro material on writing your own functions](http://cran.r-project.org/doc/manuals/R-intro.html#Writing-your-own-R-intro.html#Writing-your-own-functions)
- Our [intro to R guide to writing functions](http://nicercode.github.io/intro/writing-functions.html) with information for a total beginner
- [Hadley Wickam's](https://twitter.com/hadleywickham) information on [functions for intermediate and advanced users](https://github.com/hadley/devtools/wiki/Functions).

## Acknowledgements
This material was developed by Daniel Falster and Rich FitzJohn.
