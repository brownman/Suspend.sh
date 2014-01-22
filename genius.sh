#!/bin/bash -xe

path=`dirname $0`



#prompt for input
if [ "$1" ];then
    level=$1
else
    echo  'Please supply productivity level'
    read level
fi


run(){
rounds=1



    echo "level choosed: $level"
    file_tasks=$path/rooms/room$level.txt
    if [ -f $file_tasks ];then
        print_good "$file_tasks exist!"
        cat $file_tasks
        sleep 2
        while read p
        do
xcowsay "$rounds rounds!"
            args=( "$p" )
            util=$path/run.sh
            if [ -f "$util" ];then


                cmd="$util ${args[@]}"
                echo "call: $cmd"
                sleep 1
                eval "$cmd"
            fi

    let 'rounds += 1'
        done < $file_tasks
    else
        print_error "oops, no such file: $file_tasks"
    fi



}
run

