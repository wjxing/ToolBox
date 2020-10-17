ifeq ($(wildcard $(TOOLBOX_HOME)),)
    $(error "TOOLBOX_HOME is not set")
endif
JOB_NUM=$(shell grep processor /proc/cpuinfo | wc -l)
MAKE=make -j$(JOB_NUM)

TOOLBOX_TOOLS=$(TOOLBOX_HOME)
TOOLBOX_SRC_DIR=$(TOOLBOX_TOOLS)/source
TOOLBOX_MAK_DIR=$(TOOLBOX_HOME)/setup/Scripts/Mak
TOOLBOX_MAK_MOD_DIR=$(TOOLBOX_MAK_DIR)/modules
TOOLBOX_OUT=$(TOOLBOX_HOME)/out
TOOLBOX_INSTALL=$(TOOLBOX_HOME)/root
