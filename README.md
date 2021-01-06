turtle
======

minimal console-based task management.


Overview
--------

Start making a new folder.

```
$ mkdir project/
$ cd project/
```

`turtle` uses folders as projects, in the same way as `git`. Start by initializing a project, and adding two tasks.

```
$ turtle init
$ turtle add "rewrite spaghetti code"
$ turtle add "find a better project name"
```

Now by writing `turtle list`, you'll get some results like this:

```
$ turtle list

 [0]   rewrite spaghetti code
 [1]   find a better project name
```

Tasks can be referred to by index `1`, `2`, or simply by name. You don't have to type in the full name.

```
$ turtle tag spaghetti #food
$ turtle did 1
```

By doing this, you would have tagged the first task with `#food`, and marked the second one as completed. Check the status by just typing `turtle`:

```
$ turtle

 [0]   rewrite spaghetti code #food

 [x]   find a better project name
```

The `status` command, the default when just typing `turtle`, shows your top 5 tasks, as well as
your recently completed tasks. As you can see, task `1` was completed, shown by an `x` in place of `1`.

You can also specify tags when adding new tasks:

```
$ turtle add "make pasta" #food #yum #kitchen
```

And remove tasks:

```
$ turtle remove pasta
$ turtle kill 2
```

As well as sticky tasks, with `+` or `float`:
```
$ turtle + pasta
$ turtle

 [0] + make pasta #food #yum #kitchen
 [1]   rewrite spaghetti code
 [2]   find a better project name
```

If you want to show all `turtle` tasks with a specific tag, you can use the `show` command:

```
$ turtle show #yum

 [0]   cucumbers #yum
 [1]   pancakes #yum
```

And if you want a log of *all* your activities, just use:

```
$ turtle log
```

Bumping tasks up or down
------------------------

To move tasks up in the list, use `rise`:

```
$ turtle rise 3
```

To move tasks down in the list, use `sink`:

```
$ turtle sink 1
```

`turtle` creates a `.turtle` folder in the directory you initialize your project in.
Inside the folder is a `database.yml` file with all of your tasks for the project.

