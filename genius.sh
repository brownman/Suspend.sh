#!/bin/bash -e
export dir_base=`pwd`

path=`dirname $0`
file=''
args=$1
level=0
source $path/cfg/struct.cfg
source $path/cfg/colors.cfg
source $path/cfg/funcs.cfg
util=$path/run.sh
if [ ! -f "$util" ];then
    reason_of_death file "$util"
    exiting
fi


is_valid_file(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
}
is_valid_array(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_02.html
    http://www.thegeekstuff.com/2010/06/bash-array-tutorial/
}
type_of(){
    http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_10_01.html
}
choose_level(){
    print_status choose_level
    #prompt for input
    if [ "$args" ];then
        level=$args
    else
        echo  'Please supply productivity level'
        read level
    fi
}
file_to_array11(){
    {
        IFS=\$
        lines=( $(cat -E $file) )
    }
}
file_to_array2(){
    lines=( $(cat $file) ) ## no quotes
}
file_to_array(){
    print_status "use:  file, lines"
    if [ ! -f "$file" ];then
        eval reason_of_death file "$file"
    fi
    if [ ! -a "$lines" ];then
        eval reason_of_death line "$lines"
    fi

    lines=()
    local args=''
    while read -r line
    do
        [[ $line = \#* ]] && continue
        #echo "$line"
        #lines=("${lines[@]}" "$line")
        if [ "$line" != ''  ];then
            #echo "line: $line"
            lines+=("$line")
        fi
    done < $file
    echo "generated: array name: lines()"
    #    echo "${lines[@]}"
    printf "%s\n" "${lines[@]}"


}

execute_lines1(){
    #gxmessage -file $file_workflow "$GXMESSAGET" -title 'ensure this workflow:'
    local str_file_workflow=$(cat $file)
    local max=${#lines[@]}
    local max_efficiency=max
    count=1
    local str_tasks=''
    for line in "${lines[@]}"
    do
        notify_send1 'continue on moving your ass around'
        local str_percent="$count of $max_efficiency"
        local     action=$( echo "$line" | awk -F '|' '{print $1}' )
        local     desc=$( echo "$line" | awk -F '|' '{print $2}' )

        #$( messageYN1 "$desc" 'action:'  )
        #local result=$?
        local result=$YES
        if [[ $result -eq $YES ]];then
            str_tasks="$str_tasks _ $count: $action"
            notify_send1 "$str_percent"
            notify_send1 "TASK: $desc"
            flite "$desc" true 
            local args=( ${action} )
            local res1=$(  "${args[@]}" )
            notify_send1 'next' 'task' 
            sleep1 60
            let "count=count+1"
        else
            flite 'breaking'
            break
        fi
    done
    tasker motivation sport
}
set_file(){
    print_status "level choosed: $level"
    file=$path/rooms/room$level.txt
    if [ -f $file ];then
        print_good "$file exist!"
    else
        reason_of_death "file" "$file"
    fi
}

execute_lines(){
    num=${#lines[@]}
    print_status "execute $num tasks ?"

    read answer
    if [ "$answer" = y ];then
        local res=''
        rounds=1
        while true;do
touch ~/Desktop/round_$rounds.txt
            for line in "${lines[@]}"
            do
                print_good "Next Task: $line"
                    if [ "$line" ];then
                        cmd="$util $line"
                        print_call "call: $cmd"
                        set +x
                        eval "$cmd"
                        #echo "$cmd"
                    else
                        print_error 'no line givven'
                    fi

                            xcowsay "$rounds rounds!"
                let 'rounds += 1'
            done
        done
    fi


}


run(){
    #set int:level ( from user's feelings )
    choose_level

    #set file ( use: level for choosing a file which consist of tasks )
    set_file

    #update array:lines ( from file's lines )
    file_to_array


    ############
    #loop: execute each line of lines()
    execute_lines
    ############
}
run

