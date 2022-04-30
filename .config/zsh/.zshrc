#!/usr/bin/env zsh

# history
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_ignore_space

# configuration
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
eval "$(mcfly init zsh)"

# zsh internal features
setopt correctall
setopt autocd

# aliases
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias sysupdate="su -c\"emaint sync -A && emerge -aDNuv @world\""

# source /home/nikit/.profile
source /home/nikit/.config/broot/launcher/bash/br

# keybinds
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# plugins
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

# alacritty window name
precmd() 
{
# output on which level (%L) this shell is running on.
# append the current directory (%~), substitute home directories with a tilde.
# "\a" bell (man 1 echo)
# "print" must be used here; echo cannot handle prompt expansions (%L)
  print -Pn "\e]0;$(id --user --name)@$(hostname): zsh[%L] %~\a"
}
