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

## Configure your text editor


```coffee
git config --global core.editor "gedit -w -s" 
```

Default is `vi`.
Other options:
    "nano --tempfile" 
    "kate"
    "subl -n -w' for Sublime Text 2.

###  Other editors 

On Windows using Notepad++ in the standard location for a 64-bit machine, you would use:

    $ git config --global core.editor "'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"

(thanks to [StackOverflow](http://stackoverflow.com/questions/1634161/how-do-i-use-notepad-or-other-with-msysgit/2486342#2486342)  for that useful tip)

On Mac, with TextWrangler if you installed TextWrangler's command line tools
then you should have an "edit" command. So you can use the git command:

    $  git config --global core.editor "edit -w"
