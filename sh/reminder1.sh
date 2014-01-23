#!/bin/bash -e

#change between false and true - to mute / unmute
mute=false
plugin_name=reminder
dir=$dir_constants/txt
file=$dir/$plugin_name.txt

if [ ! -d $dir ];then
    mkdir $dir
fi
if [ ! -f $file ];then
    touch $file
fi
if [ ! -s $file ];then
    reason_of_death  $file empty
    exiting
fi

cmd=${1:-'run'}

run(){
local line=$(random_line $file)
notify-send "$line" & 
if [ "$mute" = false ];then

echo "$line" | flite -voice slt &
sleep 1
echo "$line" | flite -voice kal &
sleep 1
echo "$line" | flite -voice awb &
fi
}


random_line(){
local file=$1
local line=$(shuf -n 1 $file)
echo "$line"
}
run
