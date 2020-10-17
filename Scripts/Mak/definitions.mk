define copy-file-to-target
$(q) mkdir -p $(dir $@)
$(q) rm -f $@
$(q) cp $< $@
endef

define link-file-to-target
[[ ! -f $(2) || -L $(2) ]] && rm -rf $(2) && ln -s $(1) $(2)
endef

include $(TOOLBOX_HOME)/setup/Scripts/Mak/env.mk

