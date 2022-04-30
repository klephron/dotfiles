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

# plugins
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh


precmd() 
{
# output on which level (%L) this shell is running on.
# append the current directory (%~), substitute home directories with a tilde.
# "\a" bell (man 1 echo)
# "print" must be used here; echo cannot handle prompt expansions (%L)
  print -Pn "\e]0;$(id --user --name)@$(hostname): zsh[%L] %~\a"
}
