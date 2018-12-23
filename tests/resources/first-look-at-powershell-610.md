First look at powershell 6.1.0

Powershell [6.1.0][1] dropped yesterday. Here is my quick look.

## New Commands 

`Get-Command | Measure-Object` on each version:

Version 6.0.4 had 316 commands, while 6.1.0 has 323 commands. Comparing a list
of commands:

On 6.0.4: `gcm | select -exp name > 6.0.4.txt` and the same on 6.1.0, then to
compare:

        compare-object (gc ./6.0.4.txt) (gc ./6.1.0.txt)

        InputObject             SideIndicator
        -----------             -------------
        ConvertFrom-Markdown    =>
        Get-ExperimentalFeature =>
        Get-MarkdownOption      =>
        Set-MarkdownOption      =>
        Show-Markdown           =>
        Start-ThreadJob         =>
        Test-Connection         =>
        Test-Json               =>
        more                    <=

---

Firstly, yay for `Test-Connection`. I had to reimplement that one by parsing
results from `ping` previously to make some of my windows modules work on PS
core. Start-ThreadJob looks interesting and I can't wait to see what the 
Markdown cmdlets do.

I'll look more at these new commands later, but while I was running
Get-Command, I thought I'd see if there were any generic performance
improvements in 6.1.0 release.

On 6.0.4:

        PS /home/harrisj> measure-command {gcm | select -exp name}                      
        Days              : 0
        Hours             : 0
        Minutes           : 0
        Seconds           : 0
        Milliseconds      : 718
        Ticks             : 7185832
        TotalDays         : 8.31693518518518E-06
        TotalHours        : 0.000199606444444444
        TotalMinutes      : 0.0119763866666667
        TotalSeconds      : 0.7185832
        TotalMilliseconds : 718.5832

On 6.1.0:

        PS /home/harrisj> measure-command {get-command | select -exp name }

        Days              : 0
        Hours             : 0
        Minutes           : 0
        Seconds           : 0
        Milliseconds      : 455
        Ticks             : 4558407
        TotalDays         : 5.27593402777778E-06
        TotalHours        : 0.000126622416666667
        TotalMinutes      : 0.007597345
        TotalSeconds      : 0.4558407
        TotalMilliseconds : 455.8407

A modest speed boost. Definitely appreciated on the old RPI 2 that hosts this
site.

### Kicking the tires on new command

## Show-Markdown

I gave this a quick try and it colour highlighted and shows a preview of the
markdown in the terminal window. It also had a -UseBrowser parameter which 
writes a tmp html and open's it in the browser. Pretty neat.

## ConvertFrom-Markdown

What you'd expect, this converts a Markdown file to html to stdout or to a 
file if specified. Who knows, I might see if I can get this site to work using
this implementation of Markdown. Currently I'm using the Markdown.pl from
Gruber.

## Get-ExperimentalFeature

Does nothing on the RPI and MacOS. Will have to spin this up on Windows and
update this article

## Test-Json

Just ran this over a json file I use in one of my projects:

    Test-Json -Json (gc ./Template.json -raw)
    True

## Start-ThreadJob

This might take a bit more time to find the true value of it, but I quickly
tried my simultaneous ping test with this and it spawned a number of PSJobs
with a PSJobTypeName of ThreadJob.

### Closing thouhghts

Thats it for now. I've heard this release focused alot on bringing Windows
cmdlets back for Windows, so not-so-much in this one for the \*nixes. Still
an improvement either way

Tags: powershell

[1]: https://github.com/PowerShell/PowerShell/releases
