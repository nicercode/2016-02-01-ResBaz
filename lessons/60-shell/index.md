---
layout: lesson
root: ../..
github_username: nicercode
bootcamp_slug: gapminder
Title: The Unix Shell
---
**Acknowledgements: Based on material by Milad Fatenejad, Sasha Wood, Radhika Khetani, Karthik Ram, Emily Davenport and John Blischak. Edited by Diego Barneche**

## Download and open lesson material:

We will spend most of our time learning about the basics of the shell by manipulating some experimental data. To get the data for this test, you will need internet access. Just enter the commands:

```
cd
git clone https://github.com/nicercode/gapminder.git
```

Followed by:

```
cd gapminder
```

These 2 commands will grab all of the data needed for this workshop from the internet. We will talk about `git` later in the workshop.

## What is the shell and how do I access it?

The *shell* is a program that presents a command line interface which allows you to control your computer using commands entered with a keyboard instead of controlling graphical user interfaces (GUIs) with a mouse/keyboard combination.

A *terminal* is a program you run that gives you access to the shell. There are many different terminal programs that vary across operating systems.
	 
Some important reasons to learn about the shell: 

1.  It is very common to encounter the shell and command-line-interfaces in scientific computing, so you will probably have to learn it eventually;

2.  The shell is a really powerful way of interacting with your computer. GUIs and the shell are complementary - by knowing both you will greatly expand the range of tasks you can accomplish with your computer. You will also be able to perform many tasks more efficiently;

3.	My reasons: access remote servers, repeatability, documentation.

The shell is just a program and there are many different shell programs that have been developed. The most common shell (and the one we will use) is called the Bourne-Again SHell (bash). Even if bash is not the default shell, it is usually installed on most systems and can be started by typing `bash` in the terminal. Many commands, especially a lot of the basic ones, work across the various shells but many things are different. I recommend sticking with bash and learning it well. ([Here is a link for more information](http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29))

## Let's get started

Open your Terminal (i.e. shell prompt)

My Terminal looks like this:

![](shell_prompt.png)

Yours might looks different (these can be easily customized). Usually includes something like `username@machinename`, followed by the current working directory (more about that soon) and a $ sign

## Entering commands into the shell

You can just enter commands directly into the shell.

```
echo Morning Canberra
```

We just used a command called `echo` and gave it an argument called `Morning Canberra`.

If you enter a command that shell doesn't recognize, it will just report an error

```
$ gobbeltdfsf
bash: gobbeltdfsf: command not found
```

Now let's enter something useful. Let's navigate to the Desktop of your computer (more on navigation very shortly)

```
cd ~
pwd
```

What does it say?

---

## How commands work in the shell

Commands are often followed by one or more options that modify their behavior, and further, by one or more arguments, the items upon which the command acts. So most commands look kind of like this:

```
e.g. ls -l ~/
```

```
command -option arguments
```

## Knowing where you are and seeing whats around

The first thing you want to do when you're somewhere new is get a map or figure out how to obtain directions. Since you're new to the shell, we're going to do just that. This is really easy to do using a GUI (just click on things). Once you learn the basic commands, you'll see that it is really easy to do in the shell too. 

Three really imporant commands:

* `pwd` *Acronym for print working directory*. Tell you where you are.  
* `cd` *Change directory*. Give it options for where to take you.  
* `ls` *Short for list*. List all the files and folders in your current location.  

Most operating systems have a hierarchical directory structure. The very top is called the `root directory`. Directories are often called "folders" because of how they are represented in GUIs. Directories are just listings of files. They can contain other files or (sub) directories.

```
$ pwd
/Users/karthik
```

Note that I'm in my *home* directory. Whenever you start up a terminal, you will start in the home directory. Every user has their own home directory where they have full access to do whatever they want. For example, my user ID is `barneche`, the `pwd` command tells us that we are in the `/Users/barneche` directory. This is the home directory for the `barneche` user. Yours should (hopefully) look different.

**Changing Directories**

You can change the working directory at any time using the `cd` command.

```
cd /usr/bin 
pwd 
ls
```
Now change back to your home again

```
cd ~
```

Tip: `~` is a shortcut for the HOME directory for any user. My home is `/Users/barneche` and I can get there two ways:

`cd /Users/barneche` OR `cd ~`.

**Full versus relative paths**

In the command line you can use both full paths (much like someone's street address with post code) OR offer relative directions from one's current location. You can do the same here.

```
cd /usr
pwd
```

We're now in the `usr/` directory. Now change to `bin/`

```
cd bin
```

This is the same as doing:

```
cd /usr/bin
```

from **anywhere**.

Tip: Just plain `cd` with no options should take you back home. Try it. `cd` to some place else and type in `cd` again.

**List all the files in this directory**

```
$ ls
Applications    Documents   Dropbox     Library     Music       Public      Desktop     Downloads         Movies      Pictures  
```

When you enter the `ls` command lists the contents of the current directory. `ls` is extremely useful both for beginners and experts. `ls` can not only list the current directory contents but also contents from anywhere without changing working directories.

e.g.

```
ls /usr
```

or even multiple directories at once

```
ls ~ /usr
```

Now we can start adding more options. Recall that commands can take both options (with a `-`) followed by arguments. Let's add some to `ls`. 

```
cd
cd gapminder
ls -l
SCI-5052:gapminder barneche$ ls -l
total 48
drwxr-xr-x  4 barneche  staff   136  7 Feb 14:14 R
-rw-r--r--  1 barneche  staff    20  7 Feb 10:55 README.md
-rw-r--r--  1 barneche  staff   476  7 Feb 10:55 analysis.R
drwxr-xr-x  4 barneche  staff   136  7 Feb 10:55 data
-rwxr-xr-x  1 barneche  staff    47  7 Feb 11:48 executable.R
-rwxr-xr-x  1 barneche  staff    38  7 Feb 11:49 executable.sh
drwxr-xr-x  3 barneche  staff   102  7 Feb 15:56 figures
-rw-r--r--  1 barneche  staff   204  7 Feb 10:55 gapminder.Rproj
-rw-r--r--  1 barneche  staff  3150  7 Feb 10:55 rich-for-functions.R
```

By adding `-l` to the command, we changed the output to the long format.

Now let's add more options

```
ls -lt
```

The `t` options now sorts by time.

Similarly you can try the following:

| Option | What it does |
| ------ | ----------- |
| -a | List all files even those that are hidden. Files starting with a `.` are considered hidden |
| -d | Only directories | 
| -F | All a trailing slash to help identify folders | 
| -h | Make file sizes human readable | 
| -l | Long format | 
| -S | Sort by file size | 
| -t | Sort by modification time | 

Try some of these. Do you see any new files that we have not discussed before? You can even combine several of these options in a single command.

What are all the extra fields in the long format?

```
$ ls -l
total 48
drwxr-xr-x  4 barneche  staff   136  7 Feb 14:14 R
-rw-r--r--  1 barneche  staff    20  7 Feb 10:55 README.md
-rw-r--r--  1 barneche  staff   476  7 Feb 10:55 analysis.R
drwxr-xr-x  4 barneche  staff   136  7 Feb 10:55 data
-rwxr-xr-x  1 barneche  staff    47  7 Feb 11:48 executable.R
-rwxr-xr-x  1 barneche  staff    38  7 Feb 11:49 executable.sh
drwxr-xr-x  3 barneche  staff   102  7 Feb 15:56 figures
-rw-r--r--  1 barneche  staff   204  7 Feb 10:55 gapminder.Rproj
-rw-r--r--  1 barneche  staff  3150  7 Feb 10:55 rich-for-functions.R
```
* Files begin with a `-` and directories with a `d`.  
* Followed by permissions for the user, group, and everyone.   
* Permissions are in the order of read, write, and execute. If any * group is missing a permission, you'll see a `-`.  
* Ignore field 3 for now (it's the number of links to the file)  
* The owner of the file  
* What group this person belongs to  
* Size of file in bytes  (Quick question: How do you change this?)  
* Date an time the file was last modified  
* Name of file.  

ONe last argument for the function `ls` now.

```
$ ls -F
Applications/    Documents/   Dropbox/     Library/     Music/       Public/      Desktop/     Downloads/         Movies/      Pictures/  
```

The `-F` flag tells the computer to list the files in a way that shows their file type. There are (probably) several items in your home directory, notice that many have a slash at the end. This tells us that all of these items are directories as opposed to files. If a file has an asterisk at the end, it is *executable*.

**Arguments**

Most programs take additional arguments that control their exact behavior. For example, `-F` and `-l` are arguments to `ls`.  The `ls` program, like many programs, take a lot of arguments. But how do we know what the options are to particular commands?

Most commonly used shell programs have a manual. You can access the manual using the `man` program. Try entering:

```
$ man ls
```

This will open the manual page for `ls`. Use the space key to go forward and b to go backwards. When you are done reading, just hit `q` to exit.

Unfortunately Git Bash for Windows does not have the `man` command. Instead, try using the `--help` flag after the command you want to learn about.

```
ls --help
```

And you also find the manual pages at many different sites online, e.g. [http://linuxmanpages.com/]().
    
Programs that are run from the shell can get extremely complicated. To see an example, open up the manual page for the `find` program, which we will use later this session. No one can possibly learn all of these arguments, of course. So you will probably find yourself referring back to the manual page frequently.

**Creating an empty file**

Lets create an empty file using the `touch` command. Enter the command:

```
$ touch testfile.txt
```

Then list the contents of the directory again using `ls`. You should see that a new entry, called `testfile`, exists. It does not have a slash at the end, showing that it is not a directory. The `touch` command just creates an empty file.

Some terminals can color the directory entries in this very convenient way. In those terminals, use `ls --color` instead of `ls`. Now your directories, files, and executables will have different colors.

You can also use the command `ls -l` to see whether items in a directory are files or directories. `ls -l` gives a lot more information too, such as the size of the file and information about the owner. If the entry is a directory, then the first letter will be a "d". The fifth column shows you the size of the entries in bytes. Notice that `testfile` has a size of zero.

Now, let's get rid of `testfile`. To remove a file, just enter the command:

```
$ rm -i testfile 
```

When prompted, type:

```
$ y
```

The `rm` command can be used to remove files. The `-i` adds the "are you sure?" message. If you enter `ls` again, you will see that `testfile` is gone.

**Quick exercise 01**

1. Change into your HOME (or wherever you downloaded the **gapminder** folder). Then into `data`. List the contents of this folder. Then change back into your home again.

---
## Exploring your file system

Other really important commands

* `file`
* `less`

**Determining file type**

```
file <filename>
```

e.g.

```
file Location.md
Location.md: ASCII English text
```

Examine files with the `less` command. Keeps the content from scrolling of the screen. You can also use the arrow keys to navigate up or down. Press enter to keep scrolling down and the `q` key to quit. 

**Quick exercise 02**

1. cd `HOME`
2. cd into a given directory
3. List directory contents with `ls -l`
4. Pick any file that looks interesting to you
5. find out what it is using `file`
6. then view it's contents using `less`

---

### Saving time with shortcuts, tab completion and wild cards

**Shortcuts**

There are some shortcuts which you should know about. Dealing with the home directory is very common. So, in the shell the tilde character, `~`, is a shortcut for your home directory. Navigate to the `data` directory, then enter the command:

```
$ ls ~
```

This prints the contents of your home directory, without you having to type the absolute path. The shortcut `..` always refers to the directory above your current directory. If I'm located at `/Users/barneche/gapminder/data/`, thus: 

```
ls ..
```

prints the contents of the `/Users/barneche/gapminder/`. You can chain these together, so:

```
ls ../../
```

prints the contents of `/Users/barneche` which is your home directory. Finally, the special directory `.` always refers to your current directory. So, `ls`, `ls .`, and `ls ././././.` all do the same thing, they print the contents of the current directory. To summarize, the commands `ls ~`, `ls ~/.`, `ls ../../`, and `ls /Users/barneche` all do exactly the same thing. These shortcuts are not necessary, they are provided for your convenience.

**Tab completion**

Bash and most other shell programs have tab completion. This means that you can begin typing in a command name or file name and just hit tab to complete entering the text. If there are multiple matches, the shell will show you all available options.

```
cd
cd 2013<tab>
```

What just happened?

Try pressing `s`, then hitting tab?

When you hit the first `tab`, nothing happens. The reason is that there are multiple directories in the home directory which start with `s`. Thus, the shell does not know which one to fill in. When you hit `tab` again, the shell will list the possible choices.

Tab completion can also fill in the names of programs. For example, enter `e<tab><tab>`. You will see the name of every program that starts with an e. One of those is echo. If you enter `ech<tab>`` you will see that `tab` completion works.

**Wildcards**

One of the biggest reasons using shell is faster than ever using a GUI file manager is that it allows for wildcards. There are special characters known as wildcards. They allow you to select files based on patterns of characters.

| Wildcard | what it means |
| -------  | -----------  | 
| * |  Matches any character | 
| ? |  Matches any single character | 
| [characters] |  Matches any character in this set | 
| ![characters] |  Matches any character NOT in this set |

Navigate to the `gapminder/data/example` directory. This directory contains examples of sequencing data. If we type `ls`, we will see that there are a bunch of files which are just four digit numbers, a few files called `NOTES`, and a folder called `sequencing_data`. By default, `ls` lists all of the files in a given directory. The `*` character is a shortcut for "everything". Thus, if you enter `ls *`, you will see all of the contents of a given directory. Now try this command:

```
$ ls *1.txt
```

This lists every file that ends with a `1.txt`. This command:

```
$ ls /usr/bin/*.sh
```

lists every file in `/usr/bin` that ends in the characters `.sh`. And this command:

```
$ ls *9*1.txt
```

lists every file in the current directory which contains the number `9`, and ends with the number `1` and the extension `.txt`. There are three such files: `3901.txt`, `7901.txt`, and `9901.txt`.

So how does this actually work? Well...when the shell (bash) sees a word that contains the `*` character, it automatically looks for files that match the given pattern. In this case, it identified four such files. Then, it replaced the `*9*1.txt` with the list of files, separated by spaces. In other the two commands:

```
$ ls *9*1.txt
$ ls 3901.txt 7901.txt 9901.txt
```
are exactly identical. The `ls` command cannot tell the difference between these two things.

**Command history**

The shell typically stores your most recent commands. View them by using the up and down arrow keys.  Typing in `history` is a great way to get a full list. Execute any (especially long commands) by referencing it with a `!`.

example: `!500` will execute line 500 from your history.

## Short exercise 01

Do each of the following using a single `ls` command without navigating to a different directory.

List all of the files in `/bin` that start with the letter `c`  
List all of the files in `/bin` that contain the letter `a`  
List all of the files in `/bin` that end in `o`  
BONUS: List all of the files in `/bin` that contain the letter `a` or the letter `t`  

## Manipulating the file system

Make directories with `mkdir`

```
mkdir directory_name
```

You can create as many folders as you like in a single call.

```
mkdir directory_name_1 directory_name_2 directory_name_3
```

Copy files with `cp`

```
cp file1 file2
```

Move files with `mv`

```
mv file1 file2
```

See the `man` command to get help on options you can use with these commands.

Remove files with `rm`

***Warning: The shell does not have a recycling bin. So any file removed with `rm` is gone forever. Use with caution.***

## Let's try out some of the commands above

First go home `cd`.  
Next create a temporary directory.


```
mkdir scratchpad
cd scratchpad
```

Make a few directories

```
mkdir dir1 dir2 dir3  
cp /etc/passwd .
```

```
ls -l
```

You can also create an entire directory structure with a single call. e.g.

```
mkdir temp
cd temp
mkdir -p project/{data,R,inst/{doc,tests,manuscript},src}
```
This will create a project called root with the following structure:

```
├── R
├── data
├── inst
│   ├── doc
│   ├── manuscript
│   └── tests
└── src
```

Create lots of subdirectories at once using brace expansions.

```
echo Experiment-{A,B,C}-master
echo {01..15}
# nest these patterns
echo a{A{1,2},B{3,4}}b
```


```
mkdir temp
cd temp
ls
mkdir dir-{0..10}
ls
```


## Command History

You can easily access previous commands.  Hit the up arrow.
Hit it again.  You can step backwards through your command history.
The down arrow takes your forwards in the command history.

^-C will cancel the command you are writing, and give you a fresh prompt.

^-R will do a reverse-search through your command history.  This
is very useful.

You can also review your recent commands with the `history` command.  Just enter:

    history

to see a numbered list of recent commands, including this just issues
`history` command.  You can reuse one of these commands directly by
referring to the number of that command.

If your history looked like this:

    259  ls *!
    260  ls boot-camp
    261  git add .

then you could repeat command #260 by simply entering:

    !260

(that's an exclamation mark).



# Getting help

* If you're not sure where a program is located, use `which`

e.g.

```
which git
``` 

* See the manual for any program with `man <program_name>`  
* Get help on a command with `<program_name> --help`  



## Short exercise 2

In your `gapminder` folder, go to the directory called `messy-folder`.  
Then create three sub-directories: `data`, `notes`, `images`.  
Then move the respective file types into their matching folder type. Go back to the main shell folder.
Rename (it's the same as mv command) `messy-folder` to `clean-folder`.

Hints: You can combine several steps into one. Tab completion and wildcards are your friends.