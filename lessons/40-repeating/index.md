---
layout: lesson
root: ../..
title: Repeating things -- the key to good data analysis in R
tutor: Daniel Falster
---

<!-- Goals

- learn how to key control structures
- learn how to debug a function using browser
- split apply combine strategy for data analysis

Approach

Show them one
Get them do second with you
Assign them
 -->

## Don't repeat yourself

Previously we looked at how you can use functions to simplify your
code. Ideally you have a function that performs a single
operation, and now you want to use it many times to do the same operation on
lots of different data. The naive way to do that would be something like this:

```coffee
  res1 <-  f(input1)
  res2 <-  f(input2)
  ...
  res10 <-  f(input10)
```

But this isn't very *nice*. Yes, by using a function, you have reduced
a substantial amount of repetition. That **is** nice. But there is
still repetition.  Repeating yourself will cost you time, both now and
later, and potentially introduce some nasty bugs. When it comes to
repetition, well, just don't.

The nice way of repeating elements of code is to use a loop of some
sort. A loop is a coding structure that reruns the same bit of code
over and over, but with only small fragments differing between
runs. In R there is a whole family of looping functions, each with
their own strengths.

We're going to look at:

1. [Repeating things with `for loops`](for-loops)
2. [The split apply combine strategy with plyr package](split-apply-combine)
