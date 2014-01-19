#!/bin/bash -e


echo "restart $1" | flite &

args="$@"
path=`dirname $0`
source $path/cfg/struct.cfg

load_cron_env(){
file_env=$dir_cfg/env_dump.cfg
source $file_env
}
run(){
load_cron_env
$dir_root/run.sh "$args"
}
run

