# GNU Make Toolkit (GMTK) may not be installed
-include require.mk

# Check for GMTK
ifdef require # GMTK is installed
  # Load modules and targets

  # Download required modules
  # Check for preferences module
  ifeq ($(wildcard $(d)pref/Makefile),) # Preferences module is not installed
    # Download preferences module
    include exec.mk
    $(call exec,git clone 'https://github.com/jlapolla/preferences.git' $(d)pref,Failed to download "preferences" module)
  endif # End check for preferences module

  # Load required modules
  # Load preferences module and extensions
  $(call ,$(call require,$(d)pref/Makefile))
  $(call ,$(call require,$(addprefix $(d)pref/extensions/,ext_vundle_install.mk ext_vundle_update.mk)))

  # Include libraries used in THIS Makefile
  include helpdoc.mk

# Create targets for THIS Makefile
# Specific rules
~/.bashrc: $(d)pref/bash/.bashrc
	cp $(d)pref/bash/.bashrc ~/.bashrc

~/.gitconfig: $(d)pref/git/.gitconfig
	cp $(d)pref/git/.gitconfig ~/.gitconfig


~/.gitignore_global: $(d)pref/git/.gitignore_global
	cp $(d)pref/git/.gitignore_global ~/.gitignore_global


~/.vimrc: $(d)pref/vim/.vimrc
	cp $(d)pref/vim/.vimrc ~/.vimrc


# Summary rules
$(call helpdoc,$(d)all,Install all required files.)
$(d)all: $(addprefix ~/,.bashrc .gitconfig .gitignore_global .vimrc) $(call ext_vundle_install,~/)
	touch $(d)all

.PHONY: $(d)update
$(call helpdoc,$(d)update,Check for updates and update existing installation if required.)
$(d)update: $(d)all $(call ext_vundle_update,~/) $(d)pref/vim-plugin-update
	cd ~/usr/local/gmtk && git pull
	cd $(d)pref && git pull

# Default goal
.DEFAULT_GOAL := help

else # GMTK is not installed
# Diagnostic message
$(info GNU Make Toolkit (GMTK) not set up. Most targets are disabled.)
$(info Run "make" to set up GMTK.)

# Default goal to install GMTK
.DEFAULT_GOAL := ~/usr/local/bin/make

endif # End check for GMTK

# Install GMTK
~/usr/local/gmtk/bin/make:
	mkdir -p ~/usr/local
	git clone https://github.com/jlapolla/gnu-make-toolkit.git ~/usr/local/gmtk

# Place GMTK wrapper script on PATH
~/usr/local/bin/make: ~/usr/local/gmtk/bin/make
	mkdir -p ~/usr/local/bin
	ln -sf ~/usr/local/gmtk/bin/make ~/usr/local/bin/make
