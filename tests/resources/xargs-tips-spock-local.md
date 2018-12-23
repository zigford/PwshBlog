Xargs tips

After 12 years being a Windows admin, I've now used powershell more than other
languages so I'm pretty fluent in it's syntax. So it makes me happy when I
stumble upon bash/linux scripting paradigms which have been brought over to
powershell.

---

It's great to see the inspiration powershell has gained from
Unix systems and also great that it makes it easier for me to remember.

One paradigm I that I wished bash/\*nix had is the `Foreach-Object` command.
It makes working on collections of objects a breeze. I often find myself
scratching my head when trying similar tasks on \*nix. Enter `xargs`

Take this simple situation: I have a directory and I want to delete everything
bar a single .config file.

    $ ls -a
    .   blog.css  .entry-23032.md      .footer.html  main.css
    ..  .config   .entry-23032.md.swp  .header.html  .title.html

My powershell brain wants to:

    $ gci | ? Name -ne '.config' | foreach-object { ri $_ }

On \*nix, Xargs is a bit like adding pipeline input to rm

    $ ls -a | grep -v '\.config' | xargs rm $_

The beauty of this is that the default item variable for xargs is `$_` which is exactly
what powershell uses in a foreach-object loop.

Of coarse the powershell line could be a bit shorter

    $ gci | ? Name -ne '\.config' | ri

If you have any comments or feedback, please [email](mailto:jesse@zigford.org) me
and let me know if you will allow your feedback to be posted here.

Tags: bash-v-powershell, xargs, bash, powershell
