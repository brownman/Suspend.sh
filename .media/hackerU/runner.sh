#!/bin/bash -e
path=`dirname $0`

# Load all files in support
for file in `ls support | grep .sh$`; do
    source support/$file
done

# Load all files in src
for file in `ls src | grep .sh$`; do
    source src/$file

    # OMG this is a bash test runner!! <3 <3 <3
    # functions=`declare -F | cut -d ' ' -f 3 | grep ^test_`
    # This style allows us to run tests in order
    file_txt=`echo $file | sed 's/sh/txt/g'`
    cat idea/$file_txt
    
    functions=`grep -h test_ src/$file | cut -d '(' -f 1`
    for i in $functions; do
        rm -rf tmp/*
        $i
        green "  $i"
    done

done
