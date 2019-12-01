TARGETS := build_vim install_vim
SRC_DIR := $(TOOLBOX_SRC_DIR)/vim

.PHONY: all $(TARGETS)

all: install_vim

build_vim:
	$(q) cd $(SRC_DIR) && $(SRC_DIR)/configure \
		--enable-multibyte \
		--enable-perlinterp=dynamic \
		--enable-rubyinterp=dynamic \
		--with-ruby-command=/usr/bin/ruby \
		--enable-pythoninterp=dynamic \
		--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
		--enable-python3interp \
		--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
		--enable-luainterp \
		--with-luajit \
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
	$(q) $(MAKE) -C $(SRC_DIR) VIMRUNTIMEDIR=$(TOOLBOX_INSTALL)/usr/share/vim/vim80
	$(q) $(MAKE) -C $(SRC_DIR) install
