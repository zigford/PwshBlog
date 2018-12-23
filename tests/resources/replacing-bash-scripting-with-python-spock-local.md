Replacing bash scripting with powershell

[This][1] article on replacing bash scripting with python was being shared
around on twitter today.

> The problem is if you want to do basically anything else, e.g. write logic, 
> use control structures, handle complex data... You're going to have big 
> problems. When Bash is coordinating external programs, it's fantastic. When 
> it's doing any work whatsoever itself, it disintegrates into a pile of 
> garbage.

To me, this is what is awesome about PowerShell. I feel like it gets the shell
part right, and also supports sane logic, data structures and so on. Sticking
to the same language for quick system admin tasks and for longer form script
writing really helps learn the ins-and-outs of a language.

As for python, I have started writing some of my regular tools for use on
linux in python and so far it just doesn't seem as natural as powershell,
although that could just be because powershell is like muscle memory for me.

I'd love to give powershell a better chance on linux, but, it is a bit slow
to spin up on the [raspberry pi](raspberry-pi.html) and not available
everywhere. For instance to use it on Gentoo, I've got it installed as a snap.

If you have any comments or feedback, please [email](mailto:jesse@zigford.org)
me and let me know if you will allow your feedback to be posted here.

Tags: shells, bash, python, scripting, powershell

[1]: https://github.com/ninjaaron/replacing-bash-scripting-with-python
