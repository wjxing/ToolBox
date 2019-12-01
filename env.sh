#!/bin/bash

if [ "xxx$TOOLBOX_HOME" == "xxx" ]; then
    c_error "TOOLBOX_HOME is not set"
    exit 1
fi
export q=@
export JOB_NUM=$(grep processor /proc/cpuinfo | wc -l)
export MAKE="make -j$JOB_NUM"

export TOOLBOX_HOME=$TOOLBOX_HOME
export TOOLBOX_TOOLS=$TOOLBOX_HOME/tools
export TOOLBOX_SRC_DIR=$TOOLBOX_TOOLS/source
export TOOLBOX_MAK_DIR=$TOOLBOX_TOOLS/setup/mak
export TOOLBOX_MOD_MAK_DIR=$TOOLBOX_MAK_DIR/modules
export TOOLBOX_OUT=$TOOLBOX_HOME/out
export TOOLBOX_INSTALL=$TOOLBOX_HOME/root
