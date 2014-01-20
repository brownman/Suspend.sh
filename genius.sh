#!/bin/bash

path=`dirname $0`

while true;do
str=`date | cut -d' ' -f4`
str=`echo "$str" | sed 's/:/_/g'`
touch ~/Desktop/suspend_$str.txt
echo suspend | flite
sleep1 10
$path/run.sh suspend 
sleep1 300
done

