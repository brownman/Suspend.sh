#!/bin/bash -e

path=`dirname $0`

source $path/cfg/struct.cfg 

if [ "$1" ];then
source "$dir_cfg/$1.cfg"
else
files=$(ls -1 $dir_cfg/*.cfg)
for file in $files
do
echo ". $file"
    . $file
done
fi
print_good 'all done'
