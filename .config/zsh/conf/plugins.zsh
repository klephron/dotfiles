# Zsh-syntax-highlighting
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
# Zsh-vi-mode
zvm_after_init() {
  source $XDG_CONFIG_HOME/zsh/conf/bindkeys.zsh
  # Fzf
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/zsh/site-functions/_fzf
  if [[ -f ~/.config/fzf ]]; then
    source ~/.config/fzf
  fi

}
source /usr/local/share/zsh/site-functions/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Broot
source $XDG_CONFIG_HOME/broot/launcher/bash/br
# Bd
source /usr/local/share/zsh/site-functions/bd-zsh/bd.plugin.zsh
# Fzf
source /usr/share/fzf/key-bindings.zsh

