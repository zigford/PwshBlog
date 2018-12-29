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
        \$f=@'
$1
'@

        Invoke-Expression ((gc function:/Get-GlobalVariables)[0] -split '\\n'|select-string -pattern 'convert_filename')
        Invoke-Expression \"Write-Output '\$f' |\$Script:convert_filename\" | out-file f2 -NoNewLine
    }"
}

source ./bb.sh
global_variables

scriptComp() {
    # $1 filename
    echo "${1}" | eval "$convert_filename" > f1
    pst "${1}"
    check_tst
}

for i in resources/*.md; do 
    title=$(lowdown "${i}" | head -1 |sed 's/<\/*p>//g')
    scriptComp "$title"
done
