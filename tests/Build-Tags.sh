#!/bin/bash

check_tst() {
    # $1 = filename
    for i in tmp2/tag_*.html; do
        a=${i#tmp2/}
        if diff tmp1/$a tmp2/$a >/dev/null; then
            echo Passed;
        else
            echo "Failed on $a"
            exit
        fi
    done
}

pst() {
    pwsh -NoLogo -Command "&{
        cd tmp2
        import-module ../../src/BlogPost; 
        Get-GlobalVariables
        New-CSS
        New-Includes
        Measure-Command {Build-Tags}
    }"
}

source ./bb.sh

scriptComp() {
    cd tmp1
    global_variables
    create_css
    create_includes
    time rebuild_tags
    cd ..
    check_tst 
}

[[ -d tmp2 ]] && rm -rf tmp2
mkdir tmp2
cp resources/*.{md,html} tmp2
pst
[[ -d tmp1 ]] && rm -rf tmp1
mkdir tmp1
cp resources/*.{md,html} tmp1
scriptComp
