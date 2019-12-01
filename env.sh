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

function c_info() {
    STR="$@"
    cprint -g "`echo $STR`"
}

function c_debug() {
    STR="$@"
    cprint -b "`echo $STR`"
}

function c_error() {
    STR="$@"
    cprint -r "`echo $STR`"
}

if [ "xxx$TOOLBOX_HOME" == "xxx" ]; then
    c_error "TOOLBOX_HOME is not set"
    exit 1
fi
export q=@
export JOB_NUM=$(grep processor /proc/cpuinfo | wc -l)
export MAKE="make -j$JOB_NUM"
export -f c_info c_debug c_error cprint 2>/dev/null

export TOOLBOX_HOME=$TOOLBOX_HOME
export TOOLBOX_SRC_DIR=$TOOLBOX_HOME/source
export TOOLBOX_MAK_DIR=$TOOLBOX_HOME/setup/mak
export TOOLBOX_MOD_MAK_DIR=$TOOLBOX_MAK_DIR/modules
export TOOLBOX_OUT=$TOOLBOX_HOME/out
export TOOLBOX_INSTALL=$TOOLBOX_HOME/root
