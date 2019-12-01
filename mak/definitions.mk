define copy-file-to-target
$(q) mkdir -p $(dir $@)
$(q) rm -f $@
$(q) cp $< $@
endef
