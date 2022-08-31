CONFIG_BINDKEYS=$XDG_CONFIG_HOME/zsh/bindkeys.zsh

# Zsh-syntax-highlighting
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
# Zsh-vi-mode
zvm_after_init() {
  source $CONFIG_BINDKEYS
  # Fzf
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/zsh/site-functions/_fzf
  if [[ -f ~/.config/fzf ]]; then
    source ~/.config/fzf
  fi

}
zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_KEYTIMEOUT=0.3
}

source /usr/local/share/zsh/site-functions/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Broot
source $XDG_CONFIG_HOME/broot/launcher/bash/br
# Bd
source /usr/local/share/zsh/site-functions/bd-zsh/bd.plugin.zsh
