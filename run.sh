#!/bin/bash -e

path=`dirname $0`
source $dir_base/cfg/struct.cfg 
source $dir_cfg/colors.cfg 
source $dir_cfg/funcs.cfg 

tail=7
print_got "got: $@"


show_history(){
    #2>&1 | tee -a $path/.log/errors.log)
    print_good "show history (+$tail):"
    cat $path/.history | tail -$tail
    echo "$dir_sh"
}

show_dependencies(){
    cat $dir_debian/control
}
show_options(){
    print_good "show available scripts:"
    ls -1 $dir_sh | sed 's/.sh//g'
}
show_edit(){
    print_status 'enter file to edit:'
    read answer
    line sh $answer
}

help(){
    print_error "please supply a script name (+-arguments)"
    sleep1 2
#    show_dependencies
    show_history
    show_options
    exit
}

if [ "$1" ];then
    filename=$1
    if [ "$2" ];then
    shift
        args=( "$@" )
    fi
    sleep1 1
    script="$dir_sh/$filename.sh" 
    if [ -f "$script" ];then

        #save command to history
        echo "$script]] ${args[@]}" >> $path/.history
        #execute
        cmd="$script ${args[@]}"
        print_call "call: $cmd"
        $cmd
    else
        print_error "file not found: $script"
        eval  exiting
    fi
else
    help
fi






