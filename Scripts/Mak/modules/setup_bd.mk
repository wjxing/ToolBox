include $(TOOLBOX_HOME)/setup/Scripts/Mak/definitions.mk
SRC_DIR := $(TOOLBOX_SRC_DIR)/bd
SRC_BIN := $(SRC_DIR)/bd
SRC_COM := $(SRC_DIR)/bash_completion.d/bd
INSTALL_BIN := $(TOOLBOX_INSTALL)/usr/bin/bd
INSTALL_COM := $(TOOLBOX_INSTALL)/etc/bash_completion.d/bd

.PHONY: all install

all: install

install: $(INSTALL_BIN) $(INSTALL_COM)

$(INSTALL_BIN): $(SRC_BIN)
	$(call copy-file-to-target)

$(INSTALL_COM): $(SRC_COM)
	$(call copy-file-to-target)
