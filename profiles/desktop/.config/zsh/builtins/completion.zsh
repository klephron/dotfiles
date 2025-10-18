autoload -U compinit promptinit
compinit
promptinit

zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true

_comp_options+=(globdots) # With hidden files
zmodload zsh/complist
