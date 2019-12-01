TARGETS := install_crash check_dep
SRC_DIR := $(TOOLBOX_SRC_DIR)/crash
SRC_BIN := $(SRC_DIR)/crash
INSTALL_BIN_DIR := $(TOOLBOX_INSTALL)/usr/bin
INSTALL_BIN := $(INSTALL_BIN_DIR)/crash64
include $(TOOLBOX_MAK_DIR)/definitions.mk

.PHONY: all $(TARGETS)

all: install_crash

install_crash: $(INSTALL_BIN)

$(INSTALL_BIN): $(SRC_BIN)
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
