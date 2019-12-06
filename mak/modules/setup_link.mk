include $(TOOLBOX_MAK_DIR)/definitions.mk

RCS_DIR := $(TOOLBOX_TOOLS)/config/rcs

.PHONY: all

all:
	$(q) mkdir -p $(HOME)/root/external
	$(q) ln -s $(RCS_DIR)/_rootrc $(HOME)/root/my_sh_init.sh
	$(q) ln -s $(TOOLBOX_INSTALL)/usr $(HOME)/root/usr
	$(q) ln -s $(TOOLBOX_INSTALL)/etc $(HOME)/root/etc
	$(q) ln -s $(TOOLBOX_HOME)/vimplugin $(HOME)/.vim
	$(q) ln -s $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh $(HOME)/.oh-my-zsh
	$(q) ln -s $(TOOLBOX_SRC_DIR)/zsh-plugin/zsh-autosuggestions $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/plugins/zsh-autosuggestions
	$(q) ln -s $(TOOLBOX_SRC_DIR)/zsh-plugin/autojump $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/plugins/autojump/autojump
	$(q) ln -s $(RCS_DIR)/_bashrc $(HOME)/.bashrc
	$(q) ln -s $(RCS_DIR)/_zshrc $(HOME)/.zshrc
	$(q) ln -s $(RCS_DIR)/_shrc $(HOME)/.shrc
	$(q) ln -s $(RCS_DIR)/_gitconfig $(HOME)/.gitconfig
	$(q) ln -s $(RCS_DIR)/_inputrc $(HOME)/.inputrc
	$(q) ln -s $(RCS_DIR)/_p10k.zsh $(HOME)/.p10k.zsh
	$(q) ln -s $(RCS_DIR)/_screenrc $(HOME)/.screenrc
	$(q) ln -s $(RCS_DIR)/_tmux.conf $(HOME)/.tmux.conf
