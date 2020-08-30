include $(TOOLBOX_HOME)/setup/Scripts/Mak/definitions.mk
SRC_DIR := $(TOOLBOX_SRC_DIR)/vim
PLUGIN_DIR := $(TOOLBOX_HOME)/vimplugin

.PHONY: all build install install_vim install_vim_plugin

all:
	$(q) echo "Not support $@ target"

build:
	$(q) cd $(SRC_DIR) && $(SRC_DIR)/configure \
		--enable-multibyte \
		--enable-perlinterp=dynamic \
		--enable-pythoninterp=dynamic \
		--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
		--enable-python3interp \
		--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
		--enable-cscope \
		--enable-gui=auto \
		--with-features=huge \
		--with-x \
		--enable-fontset \
		--enable-largefile \
		--disable-netbeans \
		--with-compiledby=$(USER) \
		--enable-fail-if-missing \
		--prefix=$(TOOLBOX_INSTALL)/usr

install_vim:
	$(q) $(MAKE) -C $(SRC_DIR) VIMRUNTIMEDIR=$(TOOLBOX_INSTALL)/usr/share/vim/vim81
	$(q) $(MAKE) -C $(SRC_DIR) install

install_vim_plugin:
	$(q) ln -s $(PLUGIN_DIR) $(HOME)/.vim

install: install_vim install_vim_plugin
