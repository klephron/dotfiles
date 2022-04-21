#!/usr/bin/env zsh
#
# configuration
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
eval "$(mcfly init zsh)"

# history
setopt appendhistory

# source /home/nikit/.profile
source /home/nikit/.config/broot/launcher/bash/br

# keybinds
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

