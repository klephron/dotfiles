# bindkey -v
bindkey -e

bindkey "^A" beginning-of-line
bindkey "^B" backward-char
bindkey "^E" end-of-line
bindkey "^F" forward-char
bindkey '^H' backward-kill-word
bindkey '^K' autosuggest-accept # zsh-autosuggestions
bindkey "^L" clear-screen
bindkey "^N" down-line-or-search
bindkey "^P" up-line-or-search

bindkey "^[B" backward-word
bindkey "^[F" forward-word

# Zsh-complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

