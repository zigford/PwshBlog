#!/bin/bash

check_tst() {
    # $1 = filename
    pass="false"
    unset lineno
    if diff tmp1/$1 tmp2/$2 >/dev/null; then
        echo Passed; return
    else
        if [[ "$(diff tmp1/$1 tmp2/$2 | wc -l)" -eq "4" ]]; then
            while read line; do
                if [[ $lineno -eq 1 ]] && [[ "$line" =~ timestamp ]]; then
                    pass="true"
                fi
                lineno=$((lineno+1))
            done <<< "$(diff tmp1/$1 tmp2/$2)" 
        fi
        if [[ "$pass" == "true" ]]; then
            echo "Passed, timestamp off"
        else
            echo Failed
            break
        fi
    fi
}

pst() {
    content=$1
    filename=$2
    if [[ $3 == yes ]]; then
        index="-Index"
        unset author
        unset timestamp
    else
        unset index
        if [[ -n $5 ]]; then
            timestamp="-Timestamp \"$5\""
        fi
        if [[ -n $6 ]]; then
            author="-Author \"$6\""
        fi
    fi
    title=$4

    pwsh -NoLogo -Command "&{
        import-module ../../src/BlogPost; 
        New-CSS
        New-Includes
        #echo 'New-HTMLPage -Content \"$content\" -FileName \"$filename\" -Title \"$title\" $index $timestamp $author'
        New-HTMLPage -Content \"$content\" -FileName \"$filename\" -Title \"$title\" $index $timestamp $author 
    }"
}

source ./bb.sh

scriptComp() {
    # $1 content
    # $2 filename
    # $3 index
    # $4 title
    # $5 timestamp
    # $6 author
    if [ -d tmp1 ]; then rm -rf tmp1; fi
    mkdir tmp1
    cp resources/"$1" tmp1
    cd tmp1
    global_variables
    create_css
    create_includes
    #echo "$@"
    create_html_page "$@"

    cd ..

    if [ -d tmp2 ]; then rm -rf tmp2; fi
    mkdir tmp2
    cp resources/"$1" tmp2
    cd tmp2
    pst "$@"

    cd ..
    check_tst $2
}

count=0
amount=5
    # $1 content
    # $2 filename
    # $3 index
    # $4 title
    # $5 timestamp
    # $6 author
dstring="Sun, 23 Dec 2018 18:48:00 +1000"
for i in resources/*.html; do 
    if [ $count -lt $amount ]; then
        file=${i##resources/}
        scriptComp "$file" postfile.html yes "Tile 1" "Jesse Harris"
        scriptComp "$file" postfile.html yes "<p>boo boo</p>" "Jesse Harris"
        scriptComp "$file" postfile.html no "Tile 1" "$dstring" "Jesse Harris"
        scriptComp "$file" postfile.html no "<p>Tile 2</p>" "$dstring" "Jesse Harris"
        scriptComp "$file" postfile.html no "<p>Tile 2</p>"
        scriptComp "$file" postfile.html no "Tile 2 fred"
    fi
    count=$((count+1))
done

#echo starting speed test
#echo Awk:
#time seq 1000 | while read r; do cat $tf | ./awkscript text entry cut >>f1; done
#echo Powershell
#time pwsh -NoLogo -Command "&{. .\pb.ps1 -Post;1..1000 |%{ gc $tf | Get-HTMLFileContent -Start text -Stop entry -Cut |out-file f2 -append}} "
