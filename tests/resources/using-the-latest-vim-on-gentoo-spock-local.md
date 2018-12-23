Using the latest vim on Gentoo

Most people (including myself until recently), think of Gentoo as a bleeding 
edge source distribution. This is pretty far from accurate as most packages 
marked stable are quite out of date. And even if you decide to accept all 
unstable packages by adding: 

            ACCEPT_KEYWORKS="~amd64"

to your make.conf file, you will likely be a bit disappointed when you can't 
get the latest gnome bits.

As my last post indicated, I'm a bit of a vim user and I want to have the 
latest vim on all my machines (Windows at work, WSL/Ubuntu 18.04 on the 
Windows box, and Gentoo at home).
To that end, here is the simple thing you need to do to get the latest Vim on 
Gentoo:

# Overview
1. Add a special keyword to vim's ACCEPT_KEYWORDS var
2. Unmerge existing vim
3. emerge the new vim

## Keywords
Newer versions of portage allow _/etc/portage/package.keywords_ to be a 
directory with simple files so that you can seperate files for seperate
packages. Now, lets check if it is a file or dir and convert it if it is 
a directory.

        cd /etc/portage
        if test -f package.keywords; then
            mv package.keywords keywords
            mkdir package.keywords
            mv keywords package.keywords/
        fi

And now, lets use the special keyword for the vim package which will
allow ebuilds from github

        echo app-editors/vim "**" > package.keywords/vim
        echo app-editors/gvim "**" >> package.keywords/vim
        echo app-editors/vim-core "**" >> package.keywords/vim

## Unmerge existing vim

        emerge --unmerge app-editors/vim app-editors/gvim

## Merge the new vim

        emerge app-editors/vim app-editors/gvim

## Final thoughts.
This is the way I did it, but thinking about it now, it may be unnessecary
to unmerge vim. You could probably get away with running _emerge --update vim gvim_

Tags: gentoo, vim, git, ebuild
