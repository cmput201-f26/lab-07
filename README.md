# ILC 7

For today's ILC, we are working with bash and the `diff` command. 

## The `diff` Command
The `diff` command is used to compare the content of two files. When working on labs, you will be given text files containing expected output. Using the `diff` command is how you will determine whether your program produces the correct output or not. This is done by comparing your output with the given expected output. 
The purpose of this ILC is for you to get familiar with reading the output produced by `diff`, so you can comfortably determine where your program went wrong in future labs.

The way to use this command is:

`diff -u file1 file2`

Note: For this course, `diff` should always be run with `-u`

## Reading `diff` Output with an Example

`a.txt` contents:
```
This is a file 
with text.
some changes may happen
```

`b.txt` contents:
```
this is a file
with text.
some changes might happen
```

`diff -u a.txt b.txt` output:
```
--- a.txt       2024-09-09 12:00:00.000000000 -0600
+++ b.txt       2024-09-09 12:00:00.000000000 -0600
@@ -1,3 +1,3 @@
-This is a file 
+this is a file
 with text.
-some changes may happen
+some changes might happen
```
**Output breakdown:**

The first two lines say that the `-` character corresponds to `a.txt`, and the `+` character corresponds to `b.txt`. Any time one of `-` or `+` appears on the output after this point, it will refer to its corresponding file. Lastly, `2024-09-09 ...` is the file's timestamp.

`@@ -1,3 +1,3 @@`: This line tells us which lines will be shown on the output given on the lines after this one:
- `-1,3` means that `diff` will show lines `1` through `3` from `a.txt`.
- `+1,3` means that `diff` will show lines `1` through `3` from `b.txt`.

The rest of the lines show the differences between both files on each line:

If at any point, there is a difference between both files on a particular line, then `diff` will show both versions of that line, with one of the two lines beginning with `-`, and the other with `+`, telling us which file these lines belong to. Example from above:

```
-This is a file 
+this is a file
```
and

```
-some changes may happen
+some changes might happen
```

If there are no differences on a line, `diff` will simply show the line common between both files with a space in the beginning (instead of `-` or `+`). Example from above:

```
 with text.
```

## Task
Your task is to create a bash script (script.sh) that compares files against each other using diff. There are 4 Testcases, each with two different versions of text files. Each Testcase contains some mistakes/differences or none at all. 

Your goal is to write a bash script that: 
* Checks for differences 
* Creates a new file in the diffoutput folder in your repository that contains the output from the diff command. (It may be helpful to look into bash for loops.)

Each diff output file should be named by which Testcase files it went through (“Testcase#Output”). For example: You are comparing Testcase 1 version 1 and version 2 files, name the file: Testcase1Output, only if there are differences in the text. If there are no differences between the two files, do not generate any files. 

## Demo 
No questions from TAs this time, we are looking for completion of this ILC. 
1. Fork and clone this repository
   <img width="1238" height="62" alt="fork" src="https://github.com/user-attachments/assets/4e022d60-014c-4ed2-b0df-9726307f7e0a" />
<img width="764" height="610" alt="image" src="https://github.com/user-attachments/assets/d819ff71-bd3b-40d9-a187-9cfa28bc3edc" />

2. Make sure your forked repository is public (Hint: Use git clone)

3. After completing your bash script, be ready to show your script file and the diffoutput folder to TAs for your mark! 


