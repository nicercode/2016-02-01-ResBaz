---
layout: lesson
root: ../..
title: Setting up git
tutor: Rich FitzJohn
---

## Basic git configuration

```coffee
git config --global user.name "Rich FitzJohn"
git config --global user.email "rich.fitzjohn@gmail.com"
git config --global color.ui "auto"
```


Please replace my name/email with yours before pasting it into a terminal. If it returns no errors, then verify that these settings were saved into your configuration file (`.gitconfig`) by running:

```coffee
git config --list
git config user.name
```

## Line endings

Different operating systems have different ideas about line endings.  To avoid headaches, on Windows run this:

```
git config --global core.autocrlf "true"
```

and on mac / linux type this:

```
git config --global core.autocrlf "input"
```

## Configure your text editor

The simple editor `nano` is likely to be the simplest thing to use (at least on a Mac).


```coffee
git config --global core.editor "nano --tempfile" 
```

The default is `vi`.  If anyone ends up with a screen does not seem to respond to anything they type, you may have activated vi.  Put your hand up and we'll help you out.


Other options:
* "gedit -w -s" 
* "kate"
* "subl -n -w' for Sublime Text 2.

###  Other editors 

On Windows using Notepad++ in the standard location for a 64-bit machine, you would use:

    $ git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

(thanks to [StackOverflow](http://stackoverflow.com/questions/1634161/how-do-i-use-notepad-or-other-with-msysgit/2486342#2486342)  for that useful tip)

On Mac, with TextWrangler if you installed TextWrangler's command line tools
then you should have an "edit" command. So you can use the git command:

    $  git config --global core.editor "edit -w"
