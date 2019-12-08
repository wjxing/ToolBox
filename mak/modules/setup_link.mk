include $(TOOLBOX_MAK_DIR)/definitions.mk

RCS_DIR := $(TOOLBOX_TOOLS)/config/rcs

.PHONY: all

all:
	$(q) mkdir -p $(HOME)/root/external
	$(q) rm -rf $(HOME)/.vim && ln -s $(TOOLBOX_HOME)/vimplugin $(HOME)/.vim
	$(q) rm -rf $(HOME)/.oh-my-zsh && ln -s $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh $(HOME)/.oh-my-zsh
	$(q) rm -rf $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/plugins/zsh-autosuggestions && ln -s $(TOOLBOX_SRC_DIR)/zsh-plugin/zsh-autosuggestions $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/plugins/zsh-autosuggestions
	$(q) rm -rf $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/themes/powerlevel10k && ln -s $(TOOLBOX_SRC_DIR)/zsh-theme/powerlevel10k $(TOOLBOX_SRC_DIR)/zsh-plugin/oh-my-zsh/themes/powerlevel10k
	$(q) $(link-file-to-target $(RCS_DIR)/_bashrc,$(HOME)/.bashrc)
	$(q) $(link-file-to-target $(RCS_DIR)/_zshrc,$(HOME)/.zshrc)
	$(q) $(link-file-to-target $(RCS_DIR)/_shrc,$(HOME)/.shrc)
	$(q) $(link-file-to-target $(RCS_DIR)/_gitconfig,$(HOME)/.gitconfig)
	$(q) $(link-file-to-target $(RCS_DIR)/_gdbinit,$(HOME)/.gdbinit)
	$(q) $(link-file-to-target $(RCS_DIR)/_inputrc,$(HOME)/.inputrc)
	$(q) $(link-file-to-target $(RCS_DIR)/_p10k.zsh,$(HOME)/.p10k.zsh)
	$(q) $(link-file-to-target $(RCS_DIR)/_screenrc,$(HOME)/.screenrc)
	$(q) $(link-file-to-target $(RCS_DIR)/_tmux.conf,$(HOME)/.tmux.conf)
	$(q) cd $(TOOLBOX_SRC_DIR)/zsh-plugin/autojump/ && ./install.py
