# HISTORY
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_ignore_space


# CONFIGURATION
autoload -U compinit promptinit
compinit
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"
eval "$(mcfly init zsh)"


# ZSH INTERNAL FEATURES
# setopt correctall
setopt autocd


# ALIASES
alias ls="ls --color -F"
alias ll="ls --color -lh"

alias sysupdate="sudo emaint sync -A && sudo emerge -aDNuv @world --exclude=\"\`awk 'END{print RS}\$0=\$0' ORS=\" \" /etc/portage/package.exclude_desktop\`\""
alias sysupdateall="sudo emaint sync -A && sudo emerge -aDNuv @world"
# source /home/nikit/.profile
source /home/nikit/.config/broot/launcher/bash/br


# KEYBINDS
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search


# PLUGINS
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh/site-functions/zsh-vi-mode/zsh-vi-mode.plugin.zsh


# OTHERS
# alacritty window name
precmd() 
{
# output on which level (%L) this shell is running on.
# append the current directory (%~), substitute home directories with a tilde.
# "\a" bell (man 1 echo)
# "print" must be used here; echo cannot handle prompt expansions (%L)
  print -Pn "\e]0;$(id --user --name)@$(hostname): zsh[%L] %~\a"
}
