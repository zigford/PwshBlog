Snaps on Gentoo

## Why?

Many will think it is heresy to put binary packages on a Gentoo system 
let alone a package system which encourages binary packages to come with
their own set of shared libraries. 

While I tend to agree, the practicality of sticking to this arrangement 
can be difficult for a couple of cases. Here are a few I can think of:

* Source not available
* No binary package or source ebuild for Gentoo
* ebuild takes too long to compile

In the case of ebuilds taking too long (eg. chromium), I have a limited
budget and can't really afford to leave my power hungry desktop on 24/7
to keep chromium builds up-to-date.

Here are a quick list of software that I use which fall into one of these 
categories:

* Citrix Reciever
* Powershell (Available as source, but no ebuild and I haven't had the 
  time to try write one myself)
* Minecraft (Gaming with the kids)
* Discord (Chatting with games)
* Chromium (Primarily a firefox user, but have some trouble with getting it 
  to see and work with Citrix)

With my excuses for putting snap's on Gentoo out of the way, here is how 
I've got it working for my systems.

## Overlay

There are a few overlay's for Gentoo out there. Even an official one 
maintained (or as the case may be, unmaintained) by 
[zyga](https://github.com/zyga) from Canonical. I tried that one, and many 
of the forks with no such luck.

After googling around I stumbled on a thread on 
[snapcraft.io](https://forum.snapcraft.io/t/gentoo-update-needed/3029/15) 
and a post from user jamesb192 about the progress on their snapd overlay. 

[JamesB192 overlay](https://github.com/JamesB192/JamesB192-overlay) works,
but it doesn't have an overlay.xml file for adding with layman. 
To overcome this, I've hosted one on my site 
[here](http://jesseharrisit.com/overlay.xml). You can add this to your 
system using overlay like this:

            echo app-portage/layman git >> /etc/portage/package.use/layman
            emerge app-portage/layman
            layman -o http://jesseharrisit.com/overlay.xml -f -a JamesB192

Now that you have the overlay installed should be able to emerge snapd 
like so:

            emerge app-emulation/snapd

*Note - You may need to adjust your kernel config and the ebuild is 
pretty good at highlighting which options need to be set.*

## Issues

During my testing of snaps on Gentoo, I've come across a couple of issues 
that either have been solved or could be solved in the ebuild

1. snap packages only install and run as root (This was solved by setting 
   suid on /usr/lib64/snapd/snap-confine, and solved in ebuild 2.34)
2. /var/lib/snapd not created (manually mkdir the directory)

## Final thoughts.

Snap packages feel like a great augmentation for Gentoo. It allows me to 
keep using Gentoo as a daily driver and augment some of it's missing 
packages with packages from more popular distros.

Tags: gentoo, snaps, overlay
