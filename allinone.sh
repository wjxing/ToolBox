#!/bin/bash

function cprint() {
    while (( $# != 0 ))
    do
        case $1 in
        -B)
            echo -ne "\033[30m";
        ;;
        -r)
            echo -ne "\033[31m";
        ;;
        -g)
            echo -ne "\033[32m";
        ;;
        -y)
            echo -ne "\033[33m";
        ;;
        -b)
            echo -ne "\033[34m";
        ;;
        -p)
            echo -ne "\033[35m";
        ;;
        -c)
            echo -ne "\033[36m";
        ;;
        -w)
            echo -ne "\033[37m";
        ;;
        -h|-help|--help)
            echo "Usage: cprint -color string";
        ;;
        *)
            echo -e "$1\033[0m"
        ;;
        esac
        shift
    done
}

function _info() {
    STR="$@"
    cprint -g "`echo $STR`"
}

function _debug() {
    STR="$@"
    cprint -b "`echo $STR`"
}

function _error() {
    STR="$@"
    cprint -r "`echo $STR`"
}

must_bins[${#must_bins[@]}]="git"
must_bins[${#must_bins[@]}]="repo"

function _check_env() {
    local miss_bins=
    for bin in ${must_bins[@]}
    do
        if ! command -v $bin >/dev/null 2>&1; then
            miss_bins+="$bin,"
        fi
    done
    miss_bins=$(echo $miss_bins | sed "s/,$//" | xargs)
    if [ "xxx$miss_bins" != "xxx" ]; then
        _error "$FUNCNAME no $miss_bins in env"
        exit 1
    fi
}

setup_tasks[${#setup_tasks[@]}]="do_setup_tools"
setup_tasks[${#setup_tasks[@]}]="do_setup_vim"

function do_setup_tools() {
    _info "$FUNCNAME start"
    _info "$FUNCNAME end"
}

function do_setup_vim() {
    _info "$FUNCNAME start"
    _info "$FUNCNAME end"
}

function _setup_tasks() {
    _info "$FUNCNAME start"
    local tmp_fifo="tmp.fifo.$$"
    local thread_num=3

    mkfifo $tmp_fifo
    exec 6<>$tmp_fifo
    rm $tmp_fifo

    for ((i=0;i<$thread_num;i++))
    do
        echo
    done >&6

    for task in ${setup_tasks[@]}
    do
        read -u6
        {
            $task
        } &
    done

    wait
    exec 6>&-
    exec 6<&-
    _info "$FUNCNAME end"
}

function main() {
    _check_env
    _setup_tasks $@
}

main $@
