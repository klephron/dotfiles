CONFIG_BINDKEYS=$XDG_CONFIG_HOME/zsh/bindkeys.zsh

# PLUGINS
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
ZSH_AUTOSUGGEST_STRATEGY="history"

source /usr/local/share/zsh/site-functions/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source /usr/local/share/zsh/site-functions/bd-zsh/bd.plugin.zsh

source $XDG_CONFIG_HOME/broot/launcher/bash/br

# Zsh-vi-mode
zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_KEYTIMEOUT=0.3
}

zvm_after_init() {
  source $CONFIG_BINDKEYS
  # Fzf
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/zsh/site-functions/_fzf
  if [[ -f ~/.config/fzf ]]; then
    source ~/.config/fzf
  fi
}

