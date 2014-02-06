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
sum.of.squares <- function(x,y) {
  x^2 + y^2
}
```

You have now created a function called `sum.of.squares` which requires
two arguments and returns the sum of the squares of these
arguments. Since you ran the code through the console, the function is
now available, like any of the other built-in functions within
R. Running `sum.of.squares(3,4)` will give you the answer `25`.

The procedure for writing any other functions is similar, involving
three key steps:

1. Define the function,
2. Load the function into the R session,
3. Use the function.

## Defining a function

Functions are defined by code with a specific format:

```coffee
function.name <- function(arg1, arg2, arg3, ...) {
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

**The `...` argument**: The `...`, or ellipsis, element in the
function definition allows for other arguments to be passed into the
function, and passed onto to another function. This technique is often
in plotting, but has uses in many other places.

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


**Some functions come with predefined arguments**

Some arguments have default values specified, such as in the example below. Arguments without a default **must** have a value supplied
for the function to run. You do not need to provide a value for those
arguments with a default, as the function will use the default value.

```coffee
add.numbers <- function(a, b=2) {
    a + b
}
```

**R functions are objects just like anything else**

* can be deleted or written over
* By default, R function arguments are lazy - they're only evaluated if they're actually used
* Can be passed as arguments to other functions or returned
  from other functions.
* You can define a function inside of another function.

```coffee
add.functions <- function(x, f1, f2) {
    f1(x) + f2(x)
}
```

**R Functions can return anything, not just a number**

Here's one returning a data frame, will use this data

```coffee
f <- function() {
	url <- "https://raw.github.com/nicercode/gapminder/master/data/gapminder-FiveYearData.csv"
	filename <- "gapminder-FiveYearData.csv"
	if (!file.exists(filename))
    	download.file(url, filename, method = "curl")
    read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
}
```

```coffee
x <- f()
```

**Qu: Who understands what's happening in this function?**

Understand better if it were named something informative:

```coffee
retrieve_data_gapminder1 <- function() {
	url <- "https://raw.github.com/nicercode/gapminder/master/data/gapminder-FiveYearData.csv"
	filename <- "gapminder-FiveYearData.csv"
	if (!file.exists(filename))
    	download.file(url, filename, method = "curl")
    read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
}
```

Now easy to know what is happening when we run it

```coffee
data <- retrieve_data_gapminder1()
```

**Qu: Do we need to know how a function works to use it?**

No, difference between *what* and *implementation*.

But you do need to know that function is working as it should.

**Qu: What if want to download another dataset?**

```coffee
retrieve_data_gapminder2 <- function() {
	url <- "https://raw.github.com/nicercode/gapminder/master/data/gapminder-2007.csv"
	filename <- "gapminder-2007.csv"
	if (!file.exists(filename))
    	download.file(url, filename, method = "curl")
    read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
}
```

```coffee
data <- retrieve_data_gapminder2()
```

**Qu: What is similar and different about the two functions?**

Can we make a single function that will work for both datasets?

```coffee
retrieve_data_gapminder <- function(url,filename) {
	if (!file.exists(filename))
    	download.file(url, filename, method = "curl")
    read.csv(filename, header=TRUE, stringsAsFactors=FALSE)
}
```

```coffee
data1 <- retrieve_data_gapminder(url = "https://raw.github.com/nicercode/gapminder/master/data/gapminder-2007.csv", filename = "gapminder-2007.csv")
```

**Further improvements:**
 --> replace filename with default, give option for other file delimiters, header argument

```coffee
retrieve_data_from_url <- function(url,filename =basename(url), sep=',', header=TRUE, ...){
	if (!file.exists(filename))
    	download.file(url, filename, method = "curl")
    read.table(filename, header=header, sep=sep, ...)
}
```

Now have a generic function that can be used to load data from any delimited text file stored at any url.

e.g.
```coffee
data <- retrieve_data_from_url("http://inundata.org/gapminderDataFiveYear.txt", sep='\t')
```

```
file.remove("gapminderDataFiveYear.txt")
```

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
url <- "https://raw.github.com/nicercode/gapminder/master/data/gapminder-FiveYearData.csv"
data <- retrieve_data_from_url(url, stringsAsFactors=FALSE)

i <- data$country == "Australia"

country <- "Australia"
i <- data$country == country
new_data <- data[,i]
new_data <- subset(data,i)
new_data <- subset(data,i, select = c("year", "pop"))
```

Now define as function

```coffee
get_population <- function(data, country) {
  data[data$country == country, c("year", "pop")]
}
```

**Qu: Is this useful given it is only a one line function?**

Yes: More readable, less code when using repeatedly --> Don't Repeat Yourself

No function is too small.
=======
Yes: Your program becomes defined around the "what" and not the "how"

```
get_population <- function(data, country) {
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
