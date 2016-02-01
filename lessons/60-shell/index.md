---
layout: lesson
root: ../..
github_username: nicercode
bootcamp_slug: gapminder
Title: The Unix Shell
tutor: Joshua Madin
---
**Materials**: If you have not already done so, please [download the lesson materials for this bootcamp](https://github.com/nicercode/2014-02-18-UTS/raw/gh-pages/data/lessons.zip), unzip it, then go to the directory `shell`, and open (double click) on the file `shell.Rproj` to open Rstudio.


## Initial setup (for Windows users only):

Open your Terminal and type the following command:

~~~
echo "export TERM=msys" >> ~/.bashrc
~~~

Then restart your machine.

## What is the shell and how do I access it?

The *shell* is a program that presents a command line interface (CLI) which allows you to control your computer using commands entered with a keyboard. Whereas, the graphical user interface (GUIs) allows you to control your computer with a mouse and keyboard combination.

A *terminal* is a program you run that gives you access to the shell. There are many different terminal programs that vary across operating systems.

The shell and R are similar in many ways; the most obvious being that you interact using a command line. However, they have been designed for very different reasons. R has been designed with data and analysis in mind. The shell is designed with the file system and running programs in mind.

Some important reasons to learn about the shell include:

1. A powerful way of interacting with your computer. You will also be able to perform many tasks more efficiently than with a GUI.

2. The shell provide an excellent mechanism for creating workflows that require different software applications, and in a repeatable way. 

3. Useful for accessing remote servers.

4. Creating documentation if you use alternatives to MS Word (e.g., Markdown, LaTeX).

5. It is very common to encounter the shell and command-line-interfaces in scientific computing, so you will probably need to learn it eventually.

The most common shell (and the one we will use) is called the Bourne-Again SHell (bash). Even if bash is not the default shell, it is usually installed on most systems and can be started by typing `bash` in the terminal. 

([Here is a link for more information](http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29))

## Let's get started

Open your Terminal (i.e., the shell prompt).

![](shell_prompt.png)

Yours might look different. Usually includes something like `username@machinename`, followed by the current working directory (more about that soon) and a `$` sign

## Entering commands into the shell

You can just enter commands directly into the shell.

~~~
echo Hello World
~~~

We just used a command called `echo` and gave it an argument called `Hello World`.

If you enter a command that shell doesn't recognize, it will just report an error.

Let's navigate to the home directory of your computer.

~~~
cd ~
pwd
~~~

What is the result?

---

## How commands work in the shell

Commands are often followed by one or more options that modify their behavior.

~~~
command -letter
command --word
~~~

Try this:

~~~
ls -l
~~~

After options, there can be one or more arguments, which are the items upon which the command acts. 

~~~
ls -l lessons
~~~

## Knowing where you are and seeing what's around

The first thing you want to do is get an idea of where you are in the file system. This is more obvious using a GUI, and you can just click on things to move around and interact with files and directories. 

The three important commands for getting around are:

* `pwd` *print working directory*. Tells you where you are.
* `cd` *change directory*. You say where you want to go.
* `ls` *list*. List all the files and folders in your current location.

Most operating systems have a hierarchical directory structure. The very top is called the *root* directory. Users have a *home* directory. Directories are often called "folders" because of how they are represented in GUIs. Directories are just listings of files. They can contain other files or (sub) directories.

~~~
$ pwd
/Users/jmadin
~~~

Note that I'm in my *home* directory. Whenever you start up a terminal, you will start in the home directory. Every user has their own home directory where they have full access to do whatever they want. For example, my user ID is `jmadin`, the `pwd` command tells me that I am in the `/Users/jmadin` directory. This is the home directory for the `jmadin` user. 

**Changing Directories**

You can change the working directory at any time using the `cd` command.

~~~
cd Desktop
pwd
ls
~~~

Now change back to your home directory again.

~~~
cd ~
~~~

Tip: `~` is a shortcut for the *home* directory for any user. My home is `/Users/jmadin` and I can get there three ways:

~~~
cd /Users/jmadin
cd ~
cd
~~~

You might be wondering why there is a **standard** shortcut for the home directory. It provides a convenient way of giving a point of access which is independent of machine and username. For instance, `~/Desktop` should work for all Mac users.

**Full versus relative paths**

In the command line you can use both full paths (much like someone's street address with post code) OR offer relative directions from one's current location. You can do the same here.

~~~
cd /usr
pwd
~~~

We're now in the `usr/` directory. We can change to the `bin` subdirectory using the relative path:

~~~
cd bin
~~~

Or the absolute path:

~~~
cd /usr/bin
~~~

The absolute path will work from anywhere. The relative path is shorter.

**List all the files in your home directory**

~~~
cd ~
ls
Applications    Documents   Dropbox     Library     Music       Public      Desktop     Downloads         Movies      Pictures
~~~

When you enter the `ls` command lists the contents of the current directory. `ls` is extremely useful both for beginners and experts. `ls` can not only list the current directory contents but also contents from anywhere without changing working directories. For example:

~~~
ls /Desktop
~~~

Or even multiple directories at once:

~~~
ls ~ /usr
~~~

Now we can start adding more options. Recall that commands can take both options (with a `-` or `--`) followed by arguments. Let's add some to `ls`.

Exercise: Go to the `60-shell` directory, which is in the `lessons` download.

~~~
cd ~/lessons/60-shell/
~~~

Now, list the contents:

~~~
ls -l
total 536
-rw-r--r--@  1 jmadin  staff    319  1 Feb 20:26 analysis.R
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat1_original.dat
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat1_subset.dat
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat2_original.dat
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat2_subset.dat
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat3_original.dat
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 dat3_subset.dat
drwxr-xr-x@ 19 jmadin  staff    646 18 Feb  2014 data
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 experiment2.txt
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 experiment_14.txt
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 figures_functions.R
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 functions.R
-rw-r--r--@  1 jmadin  staff      0 18 Feb  2014 my_MS.txt
-rw-r--r--   1 jmadin  staff   1498  1 Feb 20:40 output.csv
-rw-r--r--@  1 jmadin  staff  65209 18 Feb  2014 sample1.jpg
-rw-r--r--@  1 jmadin  staff  65209 18 Feb  2014 sample2.jpg
-rw-r--r--@  1 jmadin  staff  65209 18 Feb  2014 sample3.jpg
-rw-r--r--@  1 jmadin  staff  65209 18 Feb  2014 sample4.jpg
-rw-r--r--@  1 jmadin  staff    205 18 Feb  2014 shell.Rproj
~~~

By adding `-l` to the command, we changed the output to the long format.

What are all the extra fields in the long format?

* Files begin with a `-` and directories with a `d`.
* Followed by permissions for the user, group, and anyone.
* Permissions are in the order of read, write, and execute. If any group is missing a permission, you'll see a `-`.
* Ignore second column for now (it's the number of links to the file).
* The owner of the file.
* What group this person belongs to.
* Size of file in bytes.
* Date an time the file was last modified.
* Name of file.

~~~
ls -lt
~~~

What's happened now? (The `t` options sorts by time.)

Try the following:

- `-a`  List all files even those that are hidden. Files starting with a `.` are considered hidden;
- `-F`  All a trailing slash to help identify folders;
- `-l`  Long format;
- `-lh` Make file sizes human readable;
- `-S`  Sort by file size;
- `-t`  Sort by modification time.
- `-F`  List the files in a way that shows their file type.
- `-G` (Mac) 
- `--color` (Windows)

Notice that you can even combine several of these options in a single command.

**The manual**

Most programs take additional arguments that control their exact behavior. For example, `-F` and `-l` are arguments to `ls`.  The `ls` program, like many programs, take a lot of arguments. But how do we know what the options are to particular commands?

Most commonly used shell programs have a manual. You can access the manual using the `man` program. Try entering:

~~~
man ls
~~~

This will open the manual page for `ls`. Use the space key to go forward and b to go backwards. When you are done reading, just hit `q` to exit.

Unfortunately GitBash for Windows does not have the `man` command. Instead, try using the `--help` flag after the command you want to learn about. For internal bahs commands such as `cd` and  `pwd` you will be able to access the help file by typing `help function`.

~~~
ls --help
help cd
~~~

And you also find the manual pages at many different sites online, e.g. [http://linuxmanpages.com/]().

Programs that are run from the shell can get extremely complicated. To see an example, open up the manual page for the `find` program. No one can possibly learn all of these arguments, of course. So you will probably find yourself referring back to the manual page frequently.

**Creating an empty file**

Create an empty file using the `touch` command. 

~~~
touch testfile
~~~

Then list the contents of the directory again using `ls`. You should see that a new entry, called `testfile`, exists. It does not have a slash at the end, showing that it is not a directory. The `touch` command just creates an empty file.

Now if you use the command `ls -l` you will notice that `testfile` has a size of zero. Remove it using:

~~~
rm -i testfile
~~~

When prompted, type `y`.

The `rm` command can be used to remove files. The `-i` adds the "are you sure?" message you see in GUIs. If you enter `ls` again, you will see that `testfile` is gone.

***Warning: The shell does not have a recycling bin / trash can. So any file removed with `rm` is gone forever. Use with caution. Remember the -i argument***

## Exploring your file system

Other really important commands

* `file`
* `less`
* `head`

**Determining file type**

~~~
file <filename>
~~~

~~~
head <filename>
~~~

You can also fully examine files with the `less` command. Keeps the content from scrolling of the screen. You can also use the arrow keys to navigate up or down. Press enter or return to keep scrolling down and the `q` key to quit.

## Exercise 01

- Change into your home directory.
- Go to the shell lesson directory.
- Go into `data`.
- List the contents of this directory.
- Choose one file to examine with the function `head`.
- Then change back into your home directory again.

---

### Saving time with shortcuts, tab completion and wild cards

**Shortcuts**

We've already discussed the tilde character, `~`, which is a shortcut for your home directory.

~~~
ls ~
~~~

This prints the contents of your home directory, without you having to type the absolute path. 

The shortcut `..` always refers to the directory below your current directory. If I'm located at `/Users/jmadin/lessons/60-shell/data`,

~~~
ls ..
~~~

will print the contents of the `60-shell`. You can chain these together, so:

~~~
ls ../../
~~~

prints the contents of `lessons`. 

Finally, the special directory `.` always refers to your current directory. So, `ls` and `ls .` do the same thing, they print the contents of the current directory. To summarize, the commands:

~~~
ls ~
ls ~/.
ls /Users/jmadin
~~~

All do exactly the same thing. 

**Tab completion**

Like R, Bash and most other shell programs have tab completion. This means that you can begin typing in a command name or file name and just hit tab to complete entering the text. If there are multiple matches, the shell will show you all available options.

~~~
cd
cd les<tab>
~~~

Try pressing `D`, then hitting tab?

When you hit the first <tab>, nothing happens. The reason is that there are multiple files and/or directories in the gapminder directory which start with `D`. The shell does not know which one to fill in. When you hit `tab` again, the shell will list the possible choices.

Tab completion can also fill in the names of programs. For example, type `e<tab><tab>`. You will see the name of every program that starts with an e. One of those is echo. If you enter `ech<tab>`` you will see that `tab` completion works.

**Wildcards**

One of the best reasons using shell is that it allows for wildcards. There are special characters that allow you to select files based on patterns of characters.

Wildcard examples:
`*`             Matches any character;
`?`             Matches any single character;
`[characters]`  Matches any character in this set;
`[!characters]` Matches any character NOT in this set.

Navigate to the `lessons/60-shell/data` directory. This directory contains examples of sequencing data. If we type `ls`, we will see that there are a bunch of files which are just four digit numbers. By default, `ls` lists all of the files in a given directory. The `*` character is a shortcut for "everything". So, if you enter `ls *`, you will see all of the contents of a given directory. Now try some of these commands:

~~~
ls *1.txt
ls /usr/bin/*.sh
ls *9*1.txt
ls 3901.txt 7901.txt 9901.txt
~~~

The last two are identical. 

## Exercise 02

- Got to your home directory: `cd ~`
- Do each of the following using a single `ls` command without navigating to a different directory:
  - List all of the files in shell material folder that start with the number 4;
  - List all of the files in shell material folder that contain the number 01 (together and in this order);
  - List all of the files in  in shell material folder that end with the number 0;
  - BONUS: List all of the files in  in shell material folder that contain the number 2 or the number 3.

## Manipulating the file system

Make directories with `mkdir`.

~~~
mkdir directory_name
~~~

You can create as many folders as you like in a single call.

~~~
mkdir directory_name_1 directory_name_2 directory_name_3
~~~

Copy files with `cp`.

~~~
cp file1 file2
~~~

Move files with `mv`.

~~~
mv file1 file2
~~~

See the `man` command to get help on options you can use with these commands.

Remove files with `rm`.

## Let's try out some of the commands above

Navigate using `cd` to the `60-shell` directory. Make a new directory using `mkdir`.

~~~
cd ~/lessons/60-shell
mkdir chapter1
cd chapter1
~~~

Now make a few directories inside `chapter1`:

~~~
mkdir dir1 dir2 dir3
cp ../*.R .
~~~

What did just happened?

~~~
ls -l
~~~

Now remove chapter1.

~~~
cd ..
rm chapter1
~~~

What did just happened? If you want to remove everything within scratchpad no matter what, you will need to add the `-r` argument to function `rm`

~~~
rm -r scratchpad
~~~

You can also create an entire directory structure with a single call. 

~~~
mkdir -p test_project/{R,data,output/{data,figures},doc}
ls test_project/
rm -r test_project/
~~~

This will create a project called `test_project` with the following structure:

|-- R/
|-- data/
|-- output/
|-- |-- data/
|-- |-- figures/
|-- doc/

One could also create lots of subdirectories at once using curly brackets expansions. Let's make sure to get it right using `echo` before actually creating the directories.

~~~
echo Experiment-{1..15}-master
~~~

~~~
mkdir temp
cd temp
ls
mkdir Experiment-{1..100}-master
ls
cd ..
rm -r temp
~~~

## Command History

The up arrow will step backwards through your command history. The down arrow takes your forwards in the command history.

* ^-C will cancel the command you are writing, and give you a fresh prompt.
* ^-R will do a reverse-search through your command history. This is very useful.

You can also review your recent commands with the `history` command. Just enter:

~~~
history
~~~

You can reuse one of these commands directly by referring to the number of that command. For example, if your history looked like this:

~~~
259  cd
260  ls lessons
261  history
~~~

then you could repeat command 260 by simply entering:

~~~
!260
~~~

## Exercise 03

- Go to your `lessons/60-shell` directory.
- Create the following folders: `docs`, `output/data`, `output/figures` and `R`.
- From within your shell material directory, move the respective file types into their matching directory type following the ([project setup](http://nicercode.github.io/2016-02-01-ResBaz/lessons/30-projects/)) lesson.

## Demonstration 1 - Multiple R sessions

Typing `R` in the shell will open an instance of R, which is no different to what's running in RStudio (well, there might be a few nice bells and whistles missing). You can open another shell, type `R`, and run another instance of the program. You can run as many as you like! However, depending on your machine's memory and processor configuration, more and more intensive R sessions will start to slow your computer down. The point is that using shell, you don't have to wait for one script to finish before starting another. You can run many analyses at the same time.

## Demonstration 2 - Remote server

This demonstration will show you how to run an instance of R on a remote server. This demonstration uses secure shell `ssh` to login to a server and secure copy `scp` to move a project and results between machines. Note that there is a much more desirable way of moving project between machines and collaborators (i.e., using version control and `git`). You'll be covering this next.

---

**Acknowledgements:** This material was developed by Joshua Madin and Diego Barneche, drawing heavily on material presented previously by Milad Fatenejad, Sasha Wood, Radhika Khetani, Karthik Ram, Emily Davenport and John Blischak.
