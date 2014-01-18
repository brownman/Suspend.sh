#!/bin/bash -e

path=`dirname $0`

loader(){
source $path/cfg/struct.cfg 
}

loader

print_good ls:
if [ "$1" ];then
eval "$dir_sh/$1"
else
ls -1 $dir_sh | sed 's/.sh//g'
fi

