TARGETS :=

.PHONY: all $(TARGETS) setup_vim

all: $(TARGETS)

setup_vim:
	$(q) $(MAKE) -C $(TOOLBOX_MOD_MAK_DIR) -f setup_vim.mk
