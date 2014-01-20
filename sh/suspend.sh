#!/bin/bash
# about file:
# plugin:        suspend
# description:   suspend the computer + limit powering-on to X seconds
# unlock: https://bugs.launchpad.net/ubuntu/+source/dbus/+bug/811441
# progress bar: http://bash.cyberciti.biz/guide/A_progress_bar_(gauge_box)
#. $TIMERTXT_CFG_FILE
timeout=60
#$TIMEOUT_LET_ME_SLEEP



suspend01(){

echo start | flite
    echo "suspend01().."
    local elapsed=0
    local before=`date +%s`

    echo -n "let me sleep timeout -  is:"
    echo "$timeout"


    sleep 5
xcowsay 'suspend!'

    sleep 1
    res=$( sudo  dbus-send --system --print-reply     --dest="org.freedesktop.UPower"     /org/freedesktop/UPower     org.freedesktop.UPower.Suspend )
    echo "res:  $res"
    local after=`date +%s`
    let elapsed=after-before
    echo -n "slept for: "
    echo "$elapsed"
    if [[ $elapsed -lt $timeout ]];then
        echo "let me sleep for at least $timeout seconds"
        sleep 5
        suspend01
    else
        echo 'you are free now - act wisely'
    fi
    #$tasks_sh commitment notebook
    #$tasks_sh commitment task 

echo end | flite
}



suspend01

