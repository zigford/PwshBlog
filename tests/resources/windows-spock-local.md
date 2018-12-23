Windows

#### My opinions of Windows

Many in the free software community regard Windows as a pile of garbage. While
it does have it's flaws, I think many of these conclusions fail to see the 
case for Windows.

I've read the [book][1] 'Show Stopper!: The Breakneck Race to Create Windows 
NT and the Next Generation at Microsoft', and there are a few other [posts][2]
around the internet about the [troubled][3] history of Windows development.

Even with all of the beuracracy that has burdened it's development, it feels
like MS have really turned a corner with Windows 10.

#### The good

Here are some of the less commonly appreciated aspects of Windows:

* Runs on extrodinarily varied hardware
* NTFS Volume Shadow Copies (Like free snapshots in btrfs and zfs)
* Can take on any number of personalities (like [WSL][6] and 32bit windows on 64bit)
* Can boot from a filesystem in a file (vhd)
* Deeply scriptable (I've seen many say Windows is GUI only. Fallacy)
* Out-of-band data deduplication. (Amazing feature that I haven't seen
  replicated as well on Linux)
* Highly customizable for business use cases
* Strong sleep / power saving support
* Robust remote desktop solution (No other OS has this implemented as well)
* Great built-in virutalization
* [Windows Subsystem for Linux][6]
* Ability to refresh the PC with the click of a button

I'm also writing this article from a Windows command prompt on a Microsoft
Surface Pro 3. By the way, did you know openssh comes built-in to Windows since
the April 2018 release?

#### The bad

Some of these items are not the fault of Windows directly, but indirectly due
to being the most popular desktop operating system. In these cases a diligent
systems administrator can overcome these negative aspects of running Windows.

* Horrible console (Improvements coming with [ConPTY][4])
* No developer culture - Many developers have created user hostile apps 
  (ie, apps that consume too many resources, start on boot, are kinda like 
  malware)
* The need to run Anti-Virus software. (Seriously annoying as often the AV
  software consumes as many resources as the apps you are running, effectivly
  halving the performance of your PC)
* Third-party application install experience. (This problem is slowly going away as
  more Win32 apps enter the store via [Project Centenial][5])

Also of note is that now that Microsoft is starting to push [S mode][7], some
of these issues may go away. Running a PC lean on third-party apps really makes
it a dream to use. Super long battery life, quiet, cool, bug-free. If you can
live with the built-in apps, I highly recommend giving it a go.

---

#### My history with Windows

My usage of windows has it's origins in MS-DOS, as it would for many who used
computers in the late 80's or earlie 90's. 

Having used PC's since then, I've always had, either through work or home a PC
running a version of Windows covering most of the major releases.

* Windows 3.11 (at home on the parents PC)
* Windows 95 (on my own PC, also began running Linux around this time)
* Windows 98 (again on my own PC)
* Windows 2000 Server (home PC)
* Windows XP (Home and Work)
* Windows 7 (Home and Work)
* Windows 8.1 (Work, testing Surface hardware)
* Windows 10 (Work)

A keen windows user may notice I skipped Milenium edition, Vista, and Windows 
8. I did use them, but never ran them for any significant amount of time. I also
haven't listed any of the Server editions that I regularly used at work.
This list is just those used as a desktop operating system.

Since Windows XP, I've also been responsible for developing an [MOE][8], and
repackaging software for use at work.

[1]: https://www.goodreads.com/book/show/1416925.Show_Stopper_
[2]: https://medium.com/@benbob/what-really-happened-with-vista-an-insiders-retrospective-f713ee77c239
[3]: https://hackernoon.com/what-really-happened-with-vista-4ca7ffb5a1a
[4]: https://blogs.msdn.microsoft.com/commandline/2018/08/02/windows-command-line-introducing-the-windows-pseudo-console-conpty/
[5]: https://www.onmsft.com/news/what-is-project-centennial
[6]: https://docs.microsoft.com/en-us/windows/wsl/about
[7]: https://support.microsoft.com/en-us/help/4020089/windows-10-in-s-mode-faq
[8]: https://en.wikipedia.org/wiki/Standard_Operating_Environment 
