-include helpdoc.mk

$(d)share/Vagrantfile: $(d)Vagrantfile-fake
	mkdir -p $(@D)
	cp $< $@

$(d)files.tar.gz: $(shell find $(d)files -type f)
	tar -C $(d)files -czf $@ $(shell find $(d)files -mindepth 1 -maxdepth 1 | sed 's:^files/::')

.PHONY: $(d)all
$(call helpdoc,$(d)all,Set up files for Vagrant.)
$(d)all: $(d)share/Vagrantfile $(d)files.tar.gz $(d)prov.sh

ifdef helpdoc
.DEFAULT_GOAL := help
else # ifdef helpdoc
.DEFAULT_GOAL := $(d)all
endif # ifdef helpdoc
