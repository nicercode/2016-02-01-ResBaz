#!/usr/bin/env Rscript

# Git diagram, by Diego from the Pasteur boot camp.

library(plyr)

plot.info  <-  function(y, text.box, text.explain, text.command) {
  # main box:
  polygon(c(1,5,5,1), c(y,y,y+1,y+1), col='grey90')
  text(3, y+0.3, text.box, pos=3)

  # Explanation
  arrows(8, y+0.5, 6, y+0.5)
  text(8, y+0.5, text.explain, pos=4)

  # Command
  if(text.command != '') {
    arrows(3, y-0.1, 3, y-0.9, col='red')
    text(3.5, y-0.5, text.command,pos=4, cex=1.1, col='red')
  }
}

fig.git.info <- function() {
  chart.info  <-
    list(list(y=9, text.box='working directory',
              text.explain='just a folder on your computer',
              text.command='$ git add'),
         list(y=7, text.box='stage',
              text.explain='get files ready to commit',
              text.command='$ git commit'),
         list(y=5, text.box='local repository',
              text.explain='the permanent history of changes',
              text.command='$ git push'),
         list(y=3, text.box='remote repository',
              text.explain='online repository (shared?)',
              text.command=''))

  par(family='Monaco', mar=rep(0, 4), cex=0.9)
  plot(0, 0, type='n', xlim=c(0,15), ylim=c(3,10),
       ylab='', xlab='', axes=FALSE)
  l_ply(chart.info, function(x) do.call(plot.info, x))
}

if (!interactive()) {
  png("git-info.png", width=500, height=400)
  fig.git.info()
  dev.off()
}
