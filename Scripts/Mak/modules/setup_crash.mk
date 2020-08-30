include $(TOOLBOX_HOME)/setup/Scripts/Mak/definitions.mk
SRC_DIR := $(TOOLBOX_SRC_DIR)/debug/crash/crash
SRC_BIN := $(SRC_DIR)/crash
INSTALL_BIN := $(TOOLBOX_INSTALL)/usr/bin/crash64
include $(TOOLBOX_MAK_DIR)/definitions.mk

.PHONY: all build install check_dep

all:
	$(q) echo "Not support $@ target"

$(INSTALL_BIN):
	$(call copy-file-to-target)
	$(q) strip $@

$(SRC_BIN): check_dep
	$(q) $(MAKE) target=ARM64 -C $(SRC_DIR)

check_dep:
	$(q) pkgnames=$$(apt-cache pkgnames libncurses5-dev)
	$(q) if [ -n "$$pkgnames" ]; then \
			echo \"Need libncurses5-dev\"; \
			exit 1; \
		fi
	$(q) pkgnames=$$(apt-cache pkgnames zlib1g-dev)
	$(q) if [ -n "$$pkgnames" ]; then \
			echo \"Need zlib1g-dev\"; \
			exit 1; \
		fi

build: $(SRC_BIN)

install: $(INSTALL_BIN)