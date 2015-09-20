# GNU Make toolkit may not be installed yet
-include require.mk

# Use modules if GNU Make toolkit is installed
ifdef require
  # Download preferences module
  ifeq ($(wildcard $(d)pref/Makefile),)
    include exec.mk
    $(call exec,git clone 'https://github.com/jlapolla/preferences.git' $(d)pref,Failed to download preferences module)
  endif # End download preferences module
  # Load preferences module and extensions
  $(call ,$(call require,$(d)pref/Makefile))
  $(call ,$(call require,$(addprefix $(d)pref/extensions/,ext_vundle_install.mk ext_vundle_update.mk)))

# Include libraries used in THIS Makefile
include helpdoc.mk

# File copy rules
$(HOME)/.bashrc: $(d)pref/bash/.bashrc
	cp $< $@

$(HOME)/.gitconfig: $(d)pref/git/.gitconfig
	cp $< $@

$(HOME)/.gitignore_global: $(d)pref/git/.gitignore_global
	cp $< $@

$(HOME)/.vimrc: $(d)pref/vim/.vimrc
	cp $< $@

# Update rules
.PHONY: $(d)update-gmtk
$(d)update-gmtk:
	cd $(HOME)/usr/local/gmtk && git pull

# Public rules
.PHONY: $(d)all
$(call helpdoc,$(d)all,Install files. Does nothing if all files are already installed.)
$(d)all: $(addprefix $(HOME)/,.bashrc .gitconfig .gitignore_global .vimrc) $(call ext_vundle_install,$(HOME)/)

.PHONY: $(d)update
$(call helpdoc,$(d)update,Check for updates and update existing installation if required.)
$(d)update: $(d)all $(d)update-gmtk $(call ext_vundle_update,$(HOME)/) $(d)pref/vim-plugin-update

.DEFAULT_GOAL := help

else # ifdef require
.DEFAULT_GOAL := $(HOME)/usr/local/bin/make
endif # ifdef require

$(HOME)/usr/local/gmtk/bin/make:
	mkdir -p $(HOME)/usr/local
	git clone 'https://github.com/jlapolla/gnu-make-toolkit.git' $(HOME)/usr/local/gmtk

$(HOME)/usr/local/bin/make: $(HOME)/usr/local/gmtk/bin/make
	mkdir -p $(@D)
	ln -s $< $@
