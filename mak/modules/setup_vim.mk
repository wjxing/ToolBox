TARGETS := build_vim install_vim update_vim_plugin
SRC_DIR := $(TOOLBOX_SRC_DIR)/vim
PLUGIN_DIR := $(TOOLBOX_HOME)/vimplugin

.PHONY: all $(TARGETS)

all: install_vim install_vim_plugin

build_vim:
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

install_vim: build_vim
	$(q) $(MAKE) -C $(SRC_DIR) VIMRUNTIMEDIR=$(TOOLBOX_INSTALL)/usr/share/vim/vim81
	$(q) $(MAKE) -C $(SRC_DIR) install

update_vim_plugin: install_vim
	$(q) mkdir -p $(PLUGIN_DIR)
	$(q) cd $(PLUGIN_DIR) && \
		(repo help manifest >/dev/null 2>&1 || \
			repo init -u git@github.com:wjxing/repo-VimBox.git --no-clone-bundle --depth=1 -b vim8 -m linux.xml) && \
		repo sync -c --no-clone-bundle --no-tags && \
		repo start --all master

install_vim_plugin: update_vim_plugin
	$(q) ln -s $(PLUGIN_DIR) $(HOME)/.vim
