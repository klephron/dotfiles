# bindkey -v
bindkey -e

bindkey "^A" beginning-of-line
bindkey "^B" backward-char
bindkey "^E" end-of-line
bindkey "^F" forward-char
bindkey '^H' backward-kill-word
bindkey "^L" clear-screen
bindkey "^N" down-line-or-search
bindkey "^P" up-line-or-search

bindkey "^[B" backward-word
bindkey "^[F" forward-word
