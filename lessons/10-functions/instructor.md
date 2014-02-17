---
layout: lesson
root: ../..
title: function instructor notes
tutor: Rich FitzJohn
---

Start with these lines copied into an Rstudio tab.

```
data <- read.csv("gapminder-FiveYearData.csv", stringsAsFactors=FALSE)
data.1982 <- data[data$year == 1982,]

y <- data.1982$lifeExp
x <- log(data.1982$gdpPercap)
X <- cbind(1, x)
c(solve(t(X) %*% X) %*% t(X) %*% y)
```

Then type these:

```
fit <- lm(lifeExp ~ log(gdpPercap), data.1982)
coef(fit)
```
