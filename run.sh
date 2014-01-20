#!/bin/bash -e

path=`dirname $0`

source $dir_base/cfg/struct.cfg 

source $dir_cfg/colors.cfg 
tail=7



if [ "$1" ];then
    echo "$@" >> $path/.history
    cmd="$dir_sh/$1.sh" 
    if [ -f "$cmd" ];then
        $(eval "$dir_sh/$1.sh" )
    fi
else
    #2>&1 | tee -a $path/.log/errors.log)
    print_good "HISTORY($tail):"
    cat $path/.history | tail -$tail
    echo "$dir_sh"

    print_good ls:
    ls -1 $dir_sh | sed 's/.sh//g'


    print_status enter file to edit:
    read answer
    line sh $answer

fi

