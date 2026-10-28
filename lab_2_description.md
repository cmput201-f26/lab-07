# Lab 2 cmput201

This lab we'll being learning some Bash programming and a bit of C programming
as well.

You will need all the setup you learned in lab 1

# **Windows Users**

Windows has an unfortunate tendency to break things. When `scp`-ing your code 
over to the lab machines, Windows will destroy your bash scripts. This means 
they **will not run** on the lab machines after you `scp` them over. You will
need to run the following command to fix each file individually on the lab 
machine, every time you copy:

```bash
sed -i 's/\r$//' <file>
```

Some examples of scripts you'll need to fix include:

```bash
sed -i 's/\r$//' check.sh
sed -i 's/\r$//' build.sh
sed -i 's/\r$//' special_files.sh
```

**If a Windows user does not do this, the code will not run.**

## Part 1 - Bash

Bash is a rather popular Unix shell. It's the default on most Linux
distributions. Z-shell is the default for Macos, but their syntax is quite
similar. In either case, if you're writing a shell script, it's usually a good
idea to first write the Bash version.

When you log onto the lab machines (`ssh lab`), the shell you're greeted with is
a Bash shell. That means you can write all you code right in the shell. Let's
start by making a new directory and going into it, on the lab machine.

```bash
cd ~/cmput201
mkdir lab-2-Bash
cd lab-2-Bash
```

We can make a file from the output of a command using redirection. For example,
the following prints `Hello lab 2`:

```bash
echo "Hello lab 2"
```

To write this output in a file, we use the `>` output redirector. It redirects
the standard output into a file:

```bash
echo "Hello lab 2" > hello_file.txt
```

You can view the contents of this file with `cat`:

```bash
cat hello_file.txt
```

Practice: Make 3-7 files containing different text. View all of them.

Now let's use iteration to make a huge amount of files. Just as in Python and C,
Bash also has for-loops. The for-loop below will print numbers from 1 through
100:

```bash
for i in {1..100}; do echo "This is the $i iteration"; done
```

In Bash, references to variables must always be prefixed with a `$`. In the loop
above, we have the variable `i`. To use it as a value, we wrote `$i`. Any
command can go in the body of the for-loop, even one that writes to files. Let's
create 100 files all with slightly different content:

```bash
for i in {1..100}; do echo "Content of file $i" > file_$i.txt; done
```

When you `ls -l` now, you'll see a huge amount of files. You can `cat` them out
individually to see their content.

We can also iterate over files in a directory! The following command will add
`special_` to all the file names. Note that `*` refers to [mostly] every file in
the current directory:

```bash
for f in *; do mv $f special_$f; done
```

### Deliverable

For this part you will need to hand in a Bash script called `special_files.sh`.
This is already present in the Github repository you cloned. You must fill in
the script to do the following:

 1. Create a new directory called `special_files`.
 2. Go into the `special_files` directory.
 3. Fill 1000 files with the content `This is file number <num>`. The files must
    be named `file_<num>.jpeg` where `<num>` is **a number from 1000 to 2000**.
 4. Delete all files from `file_1400.jpeg` to `file_1699.jpeg`, inclusive.
 5. Prepend `special_` in front of all remaining files (you must use `*`).

You must use Bash for-loops for steps 3, 4, and 5.

To test your script, `scp` your Github directory over to the lab machines as
before:

```bash
scp -r lab-2-cmput201-<username> lab:~/cmput201
```

Then in a separate terminal, login to your lab machine with `ssh lab`, go into
the lab 2 directory `cd ~/cmput201/lab-2-cmput201-<username>`, and run your
script:

```bash
bash special_files.sh
```

`ls -l` should show you a new directory called `special_files`. You can go into
this directory and check the content. To re-run an updated version of your
script, remove the `special_files` directory using `rm -rf special_files`.

Remember to do all your testing on the lab machines. Push the updated version of
`special_files.sh` to Github before the deadline.

Remember, if you're on Windows, you need to run the `sed` command in the first 
section, otherwise your code won't run.

## Part 2 - Small sorting

In this part, we'll write a short C program to sort the input of up to 3
integers. The program will take in argument `n`, where `0 <= n <= 3`, followed
by `n` numbers which you'll need to sort. Fill in `main.c` with the program.

Example input 1:

```
./a.out 3 9 7 8
```

Example output 1:

```
7 8 9
```

In this case the arguments to the program are `3 9 7 8`. The first argument
(`3`) is the `n` we mentioned above. It means there are `3` numbers we need to
sort in the input. These `3` numbers are `9 7 8`. The program sorts them, then
prints them out in ascending order.

Example input 2:

```
./a.out 2 10000 8
```

Example output 2:

```
8 10000
```

Make sure to print a new line in your output. Do not output anything other than
the exact answer, no extra trailing characters. If `n == 0`, output a blank
line.

Once you're ready to test you program, start by copying the Github repository
you cloned to the lab machines:

```bash
scp -r lab-2-cmput201-<username> lab:~/cmput201
```

Now on the lab machines, navigate over to the directory you just copied, compile
and run your program:

```bash
ssh lab
cd ~/cmput201/lab-2-cmput201-<username>
gcc -std=c99 -Wall -Wextra -Werror main.c
./a.out
```

Don't try to copy all those lines and paste them into your terminal all at once.
Type them out one at a time.

You should also use the included check script to test your program for you (on
the lab machines). Passing this check script is half the mark, so not running it
pretty much guarantees a failing grade:

```bash
bash check.sh main.c
```

If it throws any errors, you'll need to go back and fix your script, `scp` you
directory to the lab machines, and test again until the check script tells you
the program is good.

## Part 3 - Putting it together

More Bash!

Shell languages, like Bash, are typically used for high-level coordination of
other tools. Python was also originally intended to do this.

Back in prehistoric times, shell languages used to be quite popular for "build
systems". This is a program that creates other programs. Notably, we know C
needs to be compiled, and typing out all those flags is exhausting. Luckily,
anything we type in the shell can be used directly in a Bash script.

Let's make a build system to compile our C program from part 2. You'll do this
in a file called `build.sh`, which should already be in the Github repository
you cloned.

Your script must do the following:

 1. Compile a C file named `main.c` using the flags `-std=c99 -Wall -Wextra
    -Werror`
 2. Rename the compiled executable `a.out` into `lab2`
 3. Run the `lab2` executable with `./lab2 3 9 1000000 3`
 4. Remove the compiled program `lab2` using `rm`

You should be able to test your script using `bash build.sh` on the lab
machines. It should run your program and not leave behind any new files (like
`a.out` or `lab2`).

Submit `build.sh` to your Github repository before the deadline on Sunday.

Remember, if you're on Windows, you need to run the `sed` command in the first 
section, otherwise your code won't run.

Side note: The gcc flags may seem confusing at this point, but it's important
you understand what they do:

 - `-Wall`: Means "warnings all", so it enables all basic warnings at compile
   time.
 - `-Wextra`: Means "warnings extra". This adds additional warnings at compile
   time, to the ones provided by `-Wall`.
 - `-Werror`: Means "warnings to errors". Usually gcc will compile programs with
   warnings, but this makes warnings into errors, preventing your program from
   compiling.
 - `-std=c99`: Means "standard = c99". C99 is the C language standard from 1999.
   Other popular standards include C11 (2011), C17 (2017), and C23 (2023). We
   use C99 to match the course textbook.
