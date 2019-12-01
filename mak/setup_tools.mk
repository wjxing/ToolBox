TARGETS := setup_bd setup_crash

.PHONY: all setup_vim

all: $(TARGETS)

setup_%:
	$(q) $(MAKE) -C $(TOOLBOX_MOD_MAK_DIR) -f $@.mk

setup_vim:
	$(q) $(MAKE) -C $(TOOLBOX_MOD_MAK_DIR) -f setup_vim.mk
