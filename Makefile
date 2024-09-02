.PHONY: install install/desktop install/server help

DESKTOP_DIR := desktop
SERVER_DIR  := server
DEVCONTAINER_DIR := dev-container
SCRIPTS_DIR := scripts
CONFIG_SDIR := config

ifndef HOME
$(error HOME is not set)
endif

ifndef XDG_CONFIG_HOME
$(error XDG_CONFIG_HOME is not set)
endif

default: help


### Install default (desktop)
install: install/desktop
		

### Install configs for desktop
install/desktop: export DOTFILES_DIR := $(DESKTOP_DIR)

install/desktop: 
	@$(MAKE) install/_current
	

### Install configs for server
install/server: export DOTFILES_DIR := $(SERVER_DIR)

install/server:
	@$(MAKE) install/_current


### Install configs for dev container
install/dev-container: export DOTFILES_DIR := $(DEVCONTAINER_DIR)

install/dev-container:
	@$(MAKE) install/_current


install/_current:
	@for var in `ls -A $(DOTFILES_DIR) | grep "^\."`; do \
		src=$(abspath $(DOTFILES_DIR)/$$var); \
		dist=$$HOME/$$var; \
		if ! [ $$src -ef $$dist ]; then \
			ln -vsfn $$src $$dist ;\
		fi \
	done

	@if [ -d $(DOTFILES_DIR)/$(CONFIG_SDIR) ]; then \
		for var in `ls -A $(DOTFILES_DIR)/$(CONFIG_SDIR)`; do \
			src=$(abspath $(DESKTOP_DIR)/$(CONFIG_SDIR)/$$var); \
			dist=$$XDG_CONFIG_HOME/$$var; \
			if [ -d $$dist ] && ! [ -L $$dist ]; then \
				echo "$$dist is not a symlink pointing to a directory." ;\
			else \
				if ! [ $$src -ef $$dist ]; then \
					ln -vsfn $$src $$dist  ;\
				fi \
			fi \
		done \
	fi

### Help 
help:
	@printf "Targets:\n"
	@awk '/^[a-zA-Z\-_0-9%:\\]+/ { \
		helpMessage = match(lastLine, /^###(.*)/); \
		if (helpMessage) { \
			helpCommand = $$1; \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			gsub("\\\\", "", helpCommand); \
			gsub(":+$$", "", helpCommand); \
			printf "  \x1b[32;01m%-26s\x1b[0m %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST) | sort -u

