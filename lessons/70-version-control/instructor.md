---
layout: lesson
root: ../..
title: git instructor notes
tutor: Rich FitzJohn
---

Things to cue up:

* [why version control](http://www.phdcomics.com/comics/archive.php?comicid=1531)
* [git's places](git-info.png)
* [git branching](http://pcottle.github.io/learnGitBranching/?NODEMO)


Copy to the etherpad:

```
# Enter these three lines at the console, but replace the dummy name/email with yours.

git config --global user.name "Apprentice carpenter"
git config --global user.email "gitrocks@gmail.com"
git config --global color.ui "auto"

# Check that this has worked by running this:

git config --list

# (you should see your name and email here, and may see a few other things, but don't worry).

# Mac users: please run
git config --global core.editor "nano --tempfile"
```
