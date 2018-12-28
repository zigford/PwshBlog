#!/bin/bash

check_tst() {
    # $1 = filename
    if diff f1 f2 >/dev/null; then
        echo Passed; return
        rm f1 f2
    else
        echo Failed
        exit
    fi
}

pst() {
    pwsh -NoLogo -Command "&{
        import-module ../src/BlogPost; 
        Find-TagsInPost $i | out-file f2
    }"
}

source ./bb.sh
global_variables

scriptComp() {
    # $1 filename
    tags_in_post "${i}" > f1
    pst "${i}"
    check_tst 
}

for i in resources/*.html; do 
    scriptComp "$i"
done
