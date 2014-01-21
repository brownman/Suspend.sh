#!/bin/bash -e

path=`dirname $0`



#prompt for input
if [ "$1" ];then
    level=$1
else
    echo  'Please supply productivity level'
    read level
fi


run(){
    echo $level
    file_tasks=$path/rooms/room$level.txt
    if [ -f $file_tasks ];then
        while read p
        do
            args=( "$p" )
            util=$path/run.sh
            if [ -f "$util" ];then
                print_status "proccessing:"
                

cmd="$util ${args[@]}"
echo "$cmd"
sleep 1
eval "$cmd"
            fi
        done < $file_tasks
    else
        print_error "oops, no such file: $file_tasks"
    fi



}

old(){
    while true;do
        str=`date | cut -d' ' -f4`
        str=`echo "$str" | sed 's/:/_/g'`
        touch ~/Desktop/suspend_$str.txt
        echo suspend | flite
        sleep 10
        $path/run.sh suspend 
        sleep 300
    done
}
run

