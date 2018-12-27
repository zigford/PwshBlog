#!/bin/bash

check_tst() {
    if diff f1 f2 >/dev/null; then
        echo Passed; return
    else
        echo Failed
        exit
    fi
}

pst() {
    pwsh -NoLogo -Command "&{
        import-module ../src/BlogPost; 
        #Invoke-Expression (Get-Content .config|out-string)
        Get-JSContent -Code GoogleAnalytics | out-file f2
    }"
}

bb() {
    source ./bb.sh
    global_variables
    . .config
    google_analytics > f1
}

writeconfig() {
    if [[ -n $2 ]]; then
        echo "global_analytics=$2" > .config
    else
        echo "Analytics file content" > file.txt
        echo "global_analytics_file=\"file.txt\"" > .config
    fi
}

cleanup() {
    if [[ -f .config ]]; then rm .config; fi
    if [[ -f file.txt ]]; then rm file.txt; fi
    if [[ -f f1 ]]; then rm f1; fi
    if [[ -f f2 ]]; then rm f2; fi
}

run() {
    bb
    cat .config | sed -e 's/^\(.*\)=\(.*\)$/\$Script:\1="\2"/' | sed -e 's/""/"/g' > new.config
    mv new.config .config
    pst
    check_tst
}

analyticsTest() {
    cleanup
    writeconfig "$@"
    run "$@"
    cleanup
}

analyticsTest "analytics" "UUID-BLAH"
analyticsTest file.txt
