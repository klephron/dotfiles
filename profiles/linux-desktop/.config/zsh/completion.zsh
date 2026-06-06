autoload -U compinit && compinit

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

_comp_options+=(globdots) # With hidden files
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
