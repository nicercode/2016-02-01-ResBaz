---
layout: lesson
root: ../..
title: git instructor notes
tutor: Diego Barneche
---

# Things to cue up:

* [why organize your project](https://twitter.com/vsbuffalo/statuses/323638476153167872)  
* [messy folders](http://nicercode.github.io/2014-02-13-UNSW/lessons/30-projects/bad_layout.png)    

# Copy to the etherpad:  

* [Carl Boettiger project setup](http://carlboettiger.info/2012/05/06/research-workflow.html)
* [PLoS Computational Biology article](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1000424)

## Exercise
1. In your project lesson folder, create 6 new folders: `R`, `data`, `output` (`data`, `figures`), `docs`;  
2. Drag your gapminder-FiveYearData.csv file to the folder `data`;  
3. In the project folder, create a new empty file: `figures.R;`  
4. In the R folder, create two new files: `functions.R`, `figures_functions.R`;  
5. From your file `analysis.R` drag all the 'analytical functions' into `R/functions.R`;  
6. From your file `analysis.R` drag all the 'plotting functions' into `R/figures_functions.R`;  
7. At the very beginning of your `analysis.R` file, `source` the new files with functions that you just created in the `R` folder and add the necessary libraries for it to work (in this case it's only `plyr`);  
8. Remove any other `library()` lines from your `analysis.R` file;  
9. Make sure you adjust the file path to your data in order to read it: `data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)`
9. Drag the last part of your `analysis.R` file (making plot) to the `figures.R` file;  
10. In `figures.R` file, make sure you source the functions files the same way you just did in your `analysis.R` file. Also make sure you clean the console on your first line using: `rm(list=ls())`
11. Create two new lines between the sourced files and the actual code in order to read and modify your data: `data <- read.csv("data/gapminder-FiveYearData.csv", stringsAsFactors=FALSE)` and `data.1982  <-  data[data$year == 1982, ]`;  
12. Finally, quit RStudio and reopen it from the `projects.Rproj` file in your project root directory;
13. Open `analysis.R` and `figures.R` and run each script entirely at once;
