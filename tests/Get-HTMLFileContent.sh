#!/bin/bash

check_tst() {
    echo -n "${1}: "
    if diff f1 f2>/dev/null; then
        echo Passed
        rm f1 f2
    else
        echo Failed
        mv f1 f1.old
        mv f2 f2.old
    fi
}

pst() {
    file=$4
    pwsh -NoLogo -Command "&{import-module ../src/BlogPost; gc $file | Get-HTMLFileContent -Start $1 -Stop $2 $3 > f2} "
}

scriptComp() {
    # $1 start
    # $2 end
    # $3 cut
    # $4 file
    cat $4 | ./Get-HTMLFileContent.awk $1 $2 $3 > f1
    if [[ "$3" == "cut" ]]; then
        pst $1 $2 "-Cut" $4
    else
        pst $1 $2 "-Cut:\$False" $4
    fi
    check_tst "$1 $2 $3 $4"
}
count=0
amount=5
for i in resources/*.html; do 
    if [ $count -lt $amount ]; then
        scriptComp text text cut "$i"
        scriptComp text text "" "$i"
        scriptComp entry entry cut "$i"
        scriptComp entry entry "" "$i"
        scriptComp text entry "" "$i"
        scriptComp text entry cut "$i"
    fi
    count=$((count+1))
done

#echo starting speed test
#echo Awk:
#time seq 1000 | while read r; do cat $tf | ./awkscript text entry cut >>f1; done
#echo Powershell
#time pwsh -NoLogo -Command "&{. .\pb.ps1 -Post;1..1000 |%{ gc $tf | Get-HTMLFileContent -Start text -Stop entry -Cut |out-file f2 -append}} "
