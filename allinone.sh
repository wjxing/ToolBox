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

must_bins[${#must_bins[@]}]="git"
must_bins[${#must_bins[@]}]="make"
must_bins[${#must_bins[@]}]="python"
must_bins[${#must_bins[@]}]="repo"
must_bins[${#must_bins[@]}]="tmux"
must_bins[${#must_bins[@]}]="zsh"

UPDATE_REPOS_MOD=
UPDATE_REPOS_GRP=

sub_tasks=

all_tasks[${#all_tasks[@]}]="do_setup_tools"
all_tasks[${#all_tasks[@]}]="do_setup_vim"

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
        c_error "$FUNCNAME no $miss_bins in env"
        exit 1
    fi
    if [ "xxx$TOOLBOX_HOME" == "xxx" ]; then
        TOOLBOX_HOME=~/Workspace/ToolBox
    fi
    echo $TOOLBOX_HOME
    if [ ! -d $TOOLBOX_HOME ]; then
        mkdir -p $TOOLBOX_HOME
    fi
}

function _check_param() {
    local ARGS=$(getopt -o g:t::u:v --long update_group,setup_tools,update_repos,setup_vim -- "$@")
    local setup_tools
    if [ $? != 0 ]; then
        c_error "$FUNCNAME getopt fail"
        exit 1
    fi
    eval set -- "${ARGS}"
    while true
    do
        case "$1" in
            -g|--update_group)
                c_info "Update repos group"
                UPDATE_REPOS_GRP=$2
                shift 2
                ;;
            -t|--setup_tools)
                c_info "Setup tools"
                case "$2" in
                    "")
                        shift 2
                        ;;
                    *)
                        setup_tools=true
                        sub_tasks="$(echo $sub_tasks $2 | xargs)"
                        shift 2
                        ;;
                esac
                ;;
            -u|--update_repos)
                c_info "Update repos"
                if [[ "xxx$2" != "xxxdisable" && "xxx$2" != "xxxonly" ]]; then
                    c_error "Not support $2"
                    exit 1
                fi
                UPDATE_REPOS_MOD=$2
                shift 2
                ;;
            -v|--setup_vim)
                c_info "Setup vim"
                single_tasks[${#single_tasks[@]}]="do_setup_vim"
                shift
                ;;
            --)
                shift
                break
                ;;
            *)
                c_error "Unknow param: $1"
                exit 1
                ;;
        esac
    done
    if [ "xxx$setup_tools" == "xxxtrue" ]; then
        single_tasks[${#single_tasks[@]}]="do_setup_tools"
    fi
}

function _update_repos() {
    if [ "xxx$UPDATE_REPOS_MOD" != "xxxdisable" ]; then
        local group="all"
        if [ "xxx" != "xxx$UPDATE_REPOS_GRP" ]; then
            group="$group,-notdefault,$UPDATE_REPOS_GRP"
        fi
        mkdir -p $TOOLBOX_HOME/tools
        cd $TOOLBOX_HOME/tools && \
            repo init -u git@github.com:wjxing/repo-ToolBox.git -g $group --no-clone-bundle --depth=5 -m linux.xml && \
            repo sync -c --no-clone-bundle --no-tags && \
            repo start --all matser
        if [ "xxx$UPDATE_REPOS_MOD" == "xxxonly" ]; then
            c_info "Update repos done"
            exit
        fi
    fi
}

function do_setup_tools() {
    c_info "$FUNCNAME start"
    if [ "xxx$sub_tasks" == "xxx" ]; then
        make -C $TOOLBOX_TOOLS -f setup/mak/setup_tools.mk
    else
        for t in $sub_tasks
        do
            make -C $TOOLBOX_TOOLS -f setup/mak/setup_tools.mk $t
        done
    fi
    c_info "$FUNCNAME end"
}

function do_setup_vim() {
    c_info "$FUNCNAME start"
    make -C $TOOLBOX_TOOLS -f setup/mak/setup_tools.mk setup_vim
    c_info "$FUNCNAME end"
}

function _setup_tasks() {
    c_info "$FUNCNAME start"
    TOOLBOX_HOME=$TOOLBOX_HOME source $TOOLBOX_HOME/tools/setup/env.sh
    local tmp_fifo="tmp.fifo.$$"
    local thread_num=3
    local tasks
    if [ ${#single_tasks[@]} -ne 0 ]; then
        tasks=${single_tasks[@]}
    else
        tasks=${all_tasks[@]}
    fi

    mkfifo $tmp_fifo
    exec 6<>$tmp_fifo
    rm $tmp_fifo

    for ((i=0;i<$thread_num;i++))
    do
        echo
    done >&6

    for task in ${tasks[@]}
    do
        read -u6
        {
            $task
        } &
    done

    wait
    exec 6>&-
    exec 6<&-
    c_info "$FUNCNAME end"
}

function main() {
    _check_env
    _check_param $@
    _update_repos
    _setup_tasks
}

trap 'exit 1' SIGINT
set -e
main $@
