#!/bin/bash

check_tst() {
    # $1 = filename
    pass="false"
    unset lineno
    if diff tmp1/outfile.html tmp2/outfile.html >/dev/null; then
        echo Passed; return
    else
        if [[ "$(diff tmp1/outfile.html tmp2/outfile.html | wc -l)" -eq "4" ]]; then
            while read line; do
                if [[ $lineno -eq 1 ]] && [[ "$line" =~ timestamp ]]; then
                    pass="true"
                fi
                lineno=$((lineno+1))
            done <<< "$(diff tmp1/outfile.html tmp2/outfile.html)" 
        fi
        if [[ "$pass" == "true" ]]; then
            echo "Passed, timestamp off"
        else
            echo Failed
            exit
        fi
    fi
}

pst() {
    unset timestamp
    if [[ -n $2 ]]; then
        timestamp="-Timestamp \"$2\""
    fi

    pwsh -NoLogo -Command "&{
        import-module ../../src/BlogPost; 
        Get-GlobalVariables
        New-CSS
        New-Includes
        ConvertTo-BlogPost -SourceFile \"$1\" \$timestamp -DestinationFile outfile.html
    }"
}

source ./bb.sh

scriptComp() {
    # $1 filename
    # $2 timestamp
    if [ -d tmp1 ]; then rm -rf tmp1; fi
    mkdir tmp1
    cp resources/"$1" tmp1
    cd tmp1
    global_variables
    create_css
    create_includes
    lowdown "$1" > f1.html
    parse_file "${1}" "${2}" "outfile.html" 

    cd ..

    if [ -d tmp2 ]; then rm -rf tmp2; fi
    mkdir tmp2
    cp resources/"$1" tmp2
    cd tmp2
    pst "$@"

    cd ..
    check_tst $2
}

amount=5
for i in resources/*.md; do 
    timestamp=$(LC_ALL=C date -r "${1}" +"$date_format_full")
    #if [ $count -lt $amount ]; then
        file=${i##resources/}
        scriptComp "$file"
        scriptComp "$file" "$timestamp"
    #fi
    #count=$((count+1))
done

#echo starting speed test
#echo Awk:
#time seq 1000 | while read r; do cat $tf | ./awkscript text entry cut >>f1; done
#echo Powershell
#time pwsh -NoLogo -Command "&{. .\pb.ps1 -Post;1..1000 |%{ gc $tf | Get-HTMLFileContent -Start text -Stop entry -Cut |out-file f2 -append}} "
