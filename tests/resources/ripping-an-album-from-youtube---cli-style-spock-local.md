Ripping an album from youtube - CLI Style

With the advent of [Spotify](https://www.spotify.com/), 
[Apple Music](https://www.apple.com/music), [Youtube](https://youtube.com), 
[Pandora](https://www.pandora.com) and many other streaming music services, the 
need to have local mp3 files doesn't crop up very often. However, my kids either
have cheap mp3 players or use their 
[3ds's](https://en.wikipedia.org/wiki/Nintendo_3DS) to play local mp3 files.

This post is a quick tip on ripping an album from youtube using a web browser and
 a few cli apps. Remember, most tasks don't need a bloated gui to be done
efficiently.

### Requirement
1. A Web browser that can play youtube videos
2. [Youtube-dl](http://rg3.github.io/youtube-dl/)
3. ffmpeg
4. Bash

### Prep work

#### Install ffmpeg
 
Ubuntu

    sudo apt-get install ffmpeg -y

Fedora

    sudo yum install ffmpeg

Gentoo

    sudo emerge ffmpeg

#### Install Youtube-DL

If your on a Debian or Ubuntu flavor of linux

    sudo apt-get install youtube-dl -y

Fedora 

    sudo yum install youtub-dl

On my favourite, Gentoo

    pip3 install youtube-dl --user

### Download the album

At this point you have all the tools you need to get the job done. Have a browse
around on youtube to find the album you want an offline copy of and copy the url of the page. Then from a
command prompt:

    mkdir ~/tmp
    cd ~/tmp
    youtube-dl -x --audio-format mp3 https://youtube.com/fullurltovideo

### Create a list file

While the audio file is downloading, your going to want to create a simple txt
file which lists the tracks, titles and start and end timings. I simply fast
forwarded through each track toward the end of the song and made note of the
mintes and seconds. I created a file with each line representing a track in the album with the following details:

_Track Number_-_Track title_-_Start duration_-_End duration_

The durations are in the form of HH:MM:SS. Here is what my file looks like:

    cat ~/tmp/list.txt
    01-The Greatest Show-00:0:00-5:08
    02-A Million Dreams-00:5:08-9:38
    03-A Million Dreams Reprise-00:9:39-10:38
    04-Come Alive-00:10:38-14:25
    05-The Other Side-00:14:25-17:58
    06-Never Enough-00:17:58-21:28
    07-This Is Me-00:21:38-25:23
    08-Rewrite the Stars-00:25:23-28:59
    09-Tightrope-00:28:59-32:50
    10-Never Enough (Reprise)-00:32:50-34:14
    11-From Now On-00:34:14-40:12

### Split the audio to seperate mp3's

Now that my file has finished downloading, I can convert the file into seperate
song files
Here is the little bash script I wrote to split the file based on the contents
of the list.txt file

    cat splitsong.sh
    #!/bin/bash

    while read -r p; do
        TRACK=$(echo "$p" | awk -F- '{print $1}')
        TITLE=$(echo "$p" | awk -F- '{print $2}')
        START=$(echo "$p" | awk -F- '{print $3}')
        END=$(echo "$p" | awk -F- '{print $4}')
        FILENAME="${TRACK} - The Greatest Showman - ${TITLE}.mp3"
        ffmpeg -i "$2" -acodec copy -ss "$START" -to "$END" "${FILENAME}" < /dev/null
    done <"$1"

I then execute the file like this:

    chmod +x splitsong.sh
    ./splitsong.sh list.txt 'Some Sound Track List-qDZLSHY1ims.mp3'

And the whole thing is over in a matter of seconds.

Tags: bash-tips, mp3, ffmpeg, cli, script, youtube, music, linux
