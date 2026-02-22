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

define make-link
	src="$(abspath $(1))" ;\
	dist="$(2)" ;\
	if [ -e "$$$$dist" ] && ! [ "$$$$src" -ef "$$$$dist" ]; then \
		bkp="$$$$dist.$(BACKUP_EXT)" ;\
		if [ -e "$$$$bkp" ]; then \
			echo "$$$$src: backup $$$$bkp already exists" ;\
		else \
			mv -v "$$$$dist" "$$$$bkp" ;\
		fi ;\
	fi ;\
	if ! [ -e "$$$$dist" ]; then \
		ln -vsfn "$$$$src" "$$$$dist" ;\
	fi
endef

define make-profile
install/$(1): FORCE
	@for var in $(shell find "$(PROFILES_DIR)/$(1)" -maxdepth 1 -name '.*' | xargs -I{} basename {} | grep -v '^$(PROFILES_CONFIG_SDIR)$$'); do \
		$(call make-link,$(PROFILES_DIR)/$(1)/$$$$var,$$$$HOME/$$$$var) ;\
	done
	@if ! [ -d "$(XDG_CONFIG_HOME)" ]; then mkdir -v "$(XDG_CONFIG_HOME)"; fi
	@if [ -d "$(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)" ]; then \
		for var in $(shell find "$(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)" -maxdepth 1 -mindepth 1 | xargs -I{} basename {}); do \
			$(call make-link,$(PROFILES_DIR)/$(1)/$(PROFILES_CONFIG_SDIR)/$$$$var,$(XDG_CONFIG_HOME)/$$$$var) ;\
		done ;\
	fi
endef

$(foreach profile, $(PROFILES), $(eval $(call make-profile,$(profile))))

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
