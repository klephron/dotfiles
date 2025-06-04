.PHONY: default install help

PROFILES_DIR := profiles
PROFILES_CONFIG_SDIR := .config
SCRIPTS_DIR := scripts


ifndef HOME
$(error HOME is not set)
endif

ifndef XDG_CONFIG_HOME
$(error XDG_CONFIG_HOME is not set)
endif


PROFILES := $(notdir $(wildcard $(PROFILES_DIR)/*))


default: help


FORCE:

define make-profile-rule

install/$(1): FORCE
	@for var in `ls -A $(PROFILES_DIR)/$(1) | grep "^\."`; do \
		src=$(abspath $(PROFILES_DIR)/$(1)/$$$$var); \
		dist=$$$$HOME/$$$$var; \
		if ! [ $$$$src -ef $$$$dist ]; then \
			ln -vsfn $$$$src $$$$dist ;\
		fi \
	done

	@if ! [ -d $(XDG_CONFIG_HOME) ]; then mkdir -v $(XDG_CONFIG_HOME); fi

	@if [ -d $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR) ]; then \
		for var in `ls -A $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)`; do \
			src=$(abspath $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)/$$$$var); \
			dist=$(XDG_CONFIG_HOME)/$$$$var; \
			if [ -d $$$$dist ] && ! [ -L $$$$dist ]; then \
				echo "$$$$dist is not a symlink pointing to a directory." ;\
			else \
				if ! [ $$$$src -ef $$$$dist ]; then \
					ln -vsfn $$$$src $$$$dist  ;\
				fi \
			fi \
		done \
	fi

endef

$(foreach profile, $(PROFILES), $(eval $(call make-profile-rule,$(profile))))

### Install default (desktop)
install: install/desktop

### List available profiles
profiles: FORCE
	@echo "Available profiles:"
	@for profile in $(PROFILES); do \
		echo "  - $$profile"; \
	done

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
