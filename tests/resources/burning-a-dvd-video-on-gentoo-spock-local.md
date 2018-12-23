Burning a DVD Video on Gentoo

Quick note for my future self

Overview
========
1. Convert media to dvd compatible format
2. Author DVD title
3. Author DVD Table of Contents
4. Convert DVD folder to ISO
5. (Optional) Loopback mount ISO and test.
6. Burn ISO to DVD

Packages Required
=================
media-video/ffmpeg  
media-video/dvdauthor  
app-cdr/dvd+rw-tools  

Commands
================
Start by using ffmpeg to convert the media to a dvd compatible format:

            ffmpeg -i Big\ Buck\ Bunny.mp4 -target pal-dvd BigBuckBunny.mpg

Now use dvdauthor to author a title

            dvdauthor -t -o dvd --video=pal -f BigBuckBunny.mpg

Add a table of contents

            dvdauthor -T -o dvd

Create the ISO file

            mkisofs -dvd-video -o BigBuckBunny.iso dvd/

(Optional) Mount to a loopback for testing

            mkdir mount
            mount -o loop BigBuckBunny.iso mount/

Play the video using VLC or some other tool to check it, then unmount

            umount mount/

Burn to a disc

            growisofs -dvd-compat -Z /dev/sr0=BigBuckBunny.iso

Credit to [andrew.46 over at the ubuntuforums](https://ubuntuforums.org/showthread.php?t=2121309)


Tags: burn-a-dvd,gentoo,ffmpeg,linux
