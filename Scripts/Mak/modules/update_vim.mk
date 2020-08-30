include $(TOOLBOX_HOME)/setup/Scripts/Mak/definitions.mk
SRC_DIR := $(TOOLBOX_SRC_DIR)/vim
PLUGIN_DIR := $(TOOLBOX_HOME)/vimplugin

.PHONY: init download

all:
	$(q) echo "Not support $@ target"

init:
	$(q) mkdir -p $(PLUGIN_DIR)
	$(q) cd $(PLUGIN_DIR) && \
		repo init -u git@github.com:wjxing/repo-VimBox.git --no-clone-bundle --depth=1 -b vim8 -m linux.xml

download:
	$(q) mkdir -p $(PLUGIN_DIR)
	$(q) cd $(PLUGIN_DIR) && \
		repo help manifest >/dev/null 2>&1 && \
		repo sync -c --no-clone-bundle --no-tags && \
		repo start --all master
