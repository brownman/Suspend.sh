#!/bin/bash -e

path=`dirname $0`

source $path/cfg/struct.cfg 

source $dir_cfg/colors.cfg 

print_good ls:
if [ "$1" ];then
eval "$dir_sh/$1.sh"
else
echo "$dir_sh"
ls -1 $dir_sh | sed 's/.sh//g'
fi

