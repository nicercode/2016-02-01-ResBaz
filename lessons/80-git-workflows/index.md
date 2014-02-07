---
layout: lesson
root: ../..
title: Git workflows
tutor: Rich FitzJohn
---

* More on branching and rebase
  http://pcottle.github.io/learnGitBranching/?NODEMO
* More on how the code lifecycle works and how you can still experiment while you use version control.
* Get everyone doing a simple push and pull of a repository.
* Clone revolve and run through to show how it just works
  https://github.com/dfalster/Revolve
* A remote repository is just a branch
* Github is amazing
  * diff
	https://github.com/dfalster/Revolve/compare/master%40%7B10day%7D...master
  * log
    https://github.com/dfalster/Revolve/commits/master/R/utils.R
  * blame
	https://github.com/dfalster/Revolve/blame/master/R/utils.R#
  * issues
    https://github.com/richfitz/modeladequacy/issues/47
  * collaboratively working
    https://github.com/dfalster/Revolve/commits/master
  * forking
  * pull requests
	https://github.com/richfitz/diversitree/pull/2/files
  * continuous integration
	https://travis-ci.org/dfalster/Revolve/
	https://travis-ci.org/richfitz/forest
* bitbucket is much the same

Not sure exactly what we want to cover here; we could work through how to get the repository that they have onto github, clone down my copy, etc.  Things could get ugly quickly though, and internet connectivity is the point.  Should do a brainstorming session here at some point.

# How version control works within a workflow

* "Fast changing" ideas files and "slow changing" files defining functions.
* Often have some scripts that are not under version control because they are just for playing.  These can be explicitly ignored by git.
* However, always be prepared to completely lose these; they may have code that depends on old versions.
* Increasing formality
  - Work interactively (small copy/paste or perhaps even just typing straight in).
  - Work on a script file that is under version control
  - Move work into functions that gravitate to the top of that file
  - Move functions into their own file
* As things move down this process, I generally expect that they will change less, but sometimes things still change a lot.

# The branch model

* Basically a folder in time to organise similar thoughts.
* Creating branches is easy:

```
git branch new_idea
git checkout new_idea
```

or

```
git checkout -b new_idea
```

* Do a series of commmits
* Merge back into your main branch

**Advantages:**

* Can remember where your last good version was
* Can squash together all the commits if you took a torturous route to the solution.
* Can make a bunch of branches off a point and try different ways of solving your problem (this one is **brilliant**)
* Can work on two different ideas at once in relative isolation
* Can work on development things (new ideas) and stable things (bug fixes)

**Disadvantages:**

* Extra things to keep track of


**Acknowledgements**: This material was adapted from ... and modified by ...
