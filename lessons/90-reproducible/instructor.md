---
layout: lesson
root: ../..
title: Reproducible research - instructor notes
tutor: Daniel Falster
---

Things to cue up:

* Title page from economist: [Science goes wrong](http://www.economist.com/news/leaders/21588069-scientific-research-has-changed-world-now-it-needs-change-itself-how-science-goes-wrong)
* [Scientists nightmare - retractions](http://www.sciencemag.org/content/314/5807/1856.summary)


## Exporting figures and tables

Open Rstudio project 90-reproducible

```coffee
# Saving tables to file
dir.create("output")
write.csv(model.data, file="output/table1.csv")

write.csv(format(model.data, digits=2, trim=TRUE), file="output/table1.csv", row.names=FALSE, quote=FALSE)
```


#One way of saving a plot to file

```coffee
pdf("output/my-plot.pdf", width=6, height=4)
myplot(data.1982,"gdpPercap","lifeExp", main =1982)
dev.off()
```

# a better way of saving to pdf

```coffee
to.pdf(myplot(data.1982,"gdpPercap","lifeExp", main=1982), "output/1982.pdf", width=6, height=4)
```

# similar approach to save png

```coffee
to.dev(myplot(data.1982, "gdpPercap","lifeExp", main=1982), png, "output/1982.png", width=600, height=400)
```
