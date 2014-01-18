#!/bin/bash -e

path=`dirname $0`

source $path/cfg/struct.cfg 

if [ "$1" ];then
eval "$dir_cfg/$1.cfg"
else
ls -1 $dir_cfg | sed 's/.cfg//g'
fi

