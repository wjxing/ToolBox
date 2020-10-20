include $(TOOLBOX_HOME)/setup/Scripts/Mak/definitions.mk
SRC_DIR := $(TOOLBOX_SRC_DIR)/fzf

.PHONY: all install

all: install

install:
	$(SRC_DIR)/install --no-bash --no-fish

