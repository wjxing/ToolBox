TARGETS := install_bd
SRC_DIR := $(TOOLBOX_SRC_DIR)/bd
SRC_BIN := $(SRC_DIR)/bd
SRC_COM := $(SRC_DIR)/bash_completion.d/bd
INSTALL_BIN_DIR := $(TOOLBOX_INSTALL)/usr/bin
INSTALL_BIN := $(INSTALL_BIN_DIR)/bd
INSTALL_COM_DIR := $(TOOLBOX_INSTALL)/etc/bash_completion.d
INSTALL_COM := $(INSTALL_COM_DIR)/bd
include $(TOOLBOX_MAK_DIR)/definitions.mk

.PHONY: all $(TARGETS)

all: install_bd

install_bd: $(INSTALL_BIN) $(INSTALL_COM)

$(INSTALL_BIN): $(SRC_BIN)
	$(call copy-file-to-target)

$(INSTALL_COM): $(SRC_COM)
	$(call copy-file-to-target)
