
**Commonly used Git commands**  

* `git init` (will initialize a new Git repository inside a folder. It * also affects all files and subfolders within. Only required once per * project. Projects are managed at a folder level. Do not nest Git projects inside each other).

* `git status` (will show you the current state of the repository. * You'll use this all the time).

* `git show-branch` (see recent commits from branches).

* `git checkout` (switch branches, or grab files from earlier commits).

* `git add` (stage files ready for committing).  
* `git commit` (commit files into Git's memory with a useful message).  
* `git branch` (list branches, create them or delete existing ones).  
* `git push` (sync changes with a remote repository).  
* `git pull` (sync changes from a remote to a local repository).  
* `git merge` (merge changes between branches).  
* `git diff` (show changes between current file and most recent commit)* .
* `git log` (see detailed logs. Using the aliases defined above, you can see shorter one-line logs and also branch activity).

There are many more commands in Git but if you master this set it should serve you well for a long time.


**Searching Git logs**

Show commits only till a certain date.
```
git ls --until="2013-10-01"
```

Show commits since a certain date

```
git ls --since="2013-10-01"
```

Grep through your logs

```
git ls --grep=exercise
```
View only last 5 logs

```
git log -n 5
git ls -n 5
```

Logs by a specific author


```
git log --author="Karthik"
git ls --author="Karthik"
```

Show only commits that were merges

```
git log --merges
```



---


**Practicing Git branching**
[http://pcottle.github.io/learnGitBranching/?NODEMO](http://pcottle.github.io/learnGitBranching/?NODEMO)
In the demo you won't have to add files so just go on comitting. Remove ?NODEMO if you want more instructions. It's a great resource for both beginners and advanced users.

---

**Additional Git resources**

* The official site for the Git (open source project. Not to be confused with GitHub). http://git-scm.com/
Read the entire e-book on Git for free here: http://git-scm.com/book
If you feel the need to use Git outside of the command line, there are many guis availalable for different platforms. http://git-scm.com/downloads/guis

* A [sample gitconfig file](https://github.com/swcarpentry/boot-camps/blob/2013-09-bristol/version-control/sample.gitconfig) with more aliases (rename to .gitconfig and replace with right credentials)

* [Longer explanation on ignore files](https://help.github.com/articles/ignoring-files): 
* [A whole repository of example ignore files for various programming languages](https://github.com/github/gitignore)  
* [Here's the one for R](https://github.com/github/gitignore/blob/master/R.gitignore)

* [Version control by example](http://www.ericsink.com/vcbe/) (free ebook) 

* A (shameless plug) for my paper on why Git is important for advancing science. 
http://www.scfbm.org/content/8/1/7

* [An extremely useful Git cheat sheet](http://www.git-tower.com/blog/git-cheat-sheet/)
