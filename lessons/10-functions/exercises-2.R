## Load in the data
dat <- read.csv("data/gapminder-FiveYearData.csv",
                stringsAsFactors=FALSE)

## This data set is great.

## http://www.gapminder.org/world/#$majorMode=chart$is;shi=t;ly=2003;lb=f;il=t;fs=11;al=54;stl=t;st=t;nsl=t;se=t$wst;tts=C$ts;sp=5.59290322580644;ti=1983$zpv;v=0$inc_x;mmid=XCOORDS;iid=phAwcNAVuyj1jiMAkmq1iMg;by=ind$inc_y;mmid=YCOORDS;iid=phAwcNAVuyj2tPLxKvvnNPA;by=ind$inc_s;uniValue=8.21;iid=phAwcNAVuyj0XOoBL_n5tAQ;by=ind$inc_c;uniValue=255;gid=CATID0;by=grp$map_x;scale=log;dataMin=283;dataMax=110808$map_y;scale=lin;dataMin=18;dataMax=87$map_s;sma=75;smi=2.65$cd;bd=0$inds=;modified=75

dat.1982 <- dat[dat$year == 1982,]

plot(lifeExp ~ gdpPercap, dat.1982, log="x")

## It'd be nice to be able to scale the points with population size
## like in the online version:

## Scale on to [0,1]
p <- (dat.1982$pop - min(dat.1982$pop)) /
  (max(dat.1982$pop) - min(dat.1982$pop))
## Convert to [0.2, 10]
cex <- 0.2 + p * (10 - 0.2)

plot(lifeExp ~ gdpPercap, dat.1982, log="x", cex=cex)

## It might be nicer if we scaled against square-root of population
## size, so that area became proportional to population size:
tmp <- sqrt(dat.1982$pop)
p <- (tmp - min(tmp)) /
  (max(tmp) - min(tmp))
cex <- 0.2 + p * (10 - 0.2)
plot(lifeExp ~ gdpPercap, dat.1982, log="x", cex=cex)

## This is exactly the sort of thing that functions are great for.
rescale <- function(x, r.out) {
  r.in <- range(x)
  p <- (x - r.in[[1]]) / diff(r.in)
  r.out[[1]] + p * diff(r.out)
}

cex <- rescale(sqrt(dat.1982$pop), c(0.2, 10))
plot(lifeExp ~ gdpPercap, dat.1982, log="x", cex=cex)

## In the plot, the points are coloured by continent.  Let's do the
## same.  Here is a small table of country/colour pairs:
col.table <- c(Asia="tomato",
               Europe="chocolate4",
               Africa="dodgerblue2",
               Americas="darkgoldenrod1",
               Oceania="green4")

cols <- unname(col.table[match(dat.1982$continent, names(col.table))])
cols <- unname(col.table[dat.1982$continent])

colour.by.category <- function(x, table) {
  unname(table[x])
}

## Note that this is longer than the function definition!  But it
## captures intent better.
col <- colour.by.category(dat.1982$continent, col.table)

plot(lifeExp ~ gdpPercap, dat.1982, log="x", cex=cex, col=col, pch=19)
