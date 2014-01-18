#!/bin/bash
path=`dirname $0`
echo -n '' > $path/tmp.cron
cat $path/crontab.txt >> $path/tmp.cron
echo -e "SHELL=${SHELL}\nPATH=${PATH}\n" >> $path/tmp.cron 

crontab $path/tmp.cron
sudo service cron restart
echo SHOW:
crontab -u dao04 -l
