define copy-file-to-target
$(q) mkdir -p $(dir $@)
$(q) rm -f $@
$(q) cp $< $@
endef

define link-file-to-target
$(q) [ ! -f $(1) || -L $(1) ] && rm $(1) && ln -s $(2) $(1)
endef
