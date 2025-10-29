.PHONY: default install help

PROFILES_DIR := profiles
PROFILES_CONFIG_SDIR := .config
SCRIPTS_DIR := scripts
BACKUP_EXT := bkp


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
	@for var in `ls -A $(PROFILES_DIR)/$(1) | grep "^\." | grep -v "$(PROFILES_CONFIG_SDIR)"`; do \
		src=$(abspath $(PROFILES_DIR)/$(1)/$$$$var) ;\
		dist=$$$$HOME/$$$$var ;\
		if [ -e $$$$dist ] && ! [ $$$$src -ef $$$$dist ]; then \
			bkp=$$$$dist.$(BACKUP_EXT); \
			if [ -e $$$$bkp ]; then \
				echo "$$$$src: backup $$$$bkp already exist" ;\
			else \
				mv -v $$$$dist $$$$bkp ;\
			fi ;\
		fi ;\
		if ! [ -e $$$$dist ]; then \
			ln -vsfn $$$$src $$$$dist ;\
		fi ;\
	done

	@if ! [ -d $(XDG_CONFIG_HOME) ]; then mkdir -v $(XDG_CONFIG_HOME); fi

	@if [ -d $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR) ]; then \
		for var in `ls -A $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)`; do \
			src=$(abspath $(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)/$$$$var) ;\
			dist=$(XDG_CONFIG_HOME)/$$$$var ;\
			if [ -e $$$$dist ] && ! [ $$$$src -ef $$$$dist ]; then \
				bkp=$$$$dist.$(BACKUP_EXT); \
				if [ -e $$$$bkp ]; then \
					echo "$$$$src: backup $$$$bkp already exist" ;\
				else \
					mv -v $$$$dist $$$$bkp ;\
				fi ;\
			fi ;\
			if ! [ -e $$$$dist ]; then \
				ln -vsfn $$$$src $$$$dist ;\
			fi ;\
		done \
	fi

endef

$(foreach profile, $(PROFILES), $(eval $(call make-profile-rule,$(profile))))

### Install default (desktop)
install: install/desktop

### List available profiles
profiles: FORCE
	@for profile in $(PROFILES); do \
		echo "$$profile"; \
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
