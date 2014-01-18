#!/bin/bash
path=`dirname $0`
file_env=$path/env_dump.cfg
source $file_env
eval "$1"
