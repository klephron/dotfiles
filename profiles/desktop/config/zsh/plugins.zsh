# PLUGINS
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
ZSH_AUTOSUGGEST_STRATEGY="history"

source /usr/share/fzf/key-bindings.zsh
if [[ -f ~/.config/fzf ]]; then
  source ~/.config/fzf
fi

source $XDG_CONFIG_HOME/zsh/plugins/mise.zsh
source $XDG_CONFIG_HOME/zsh/plugins/zoxide.zsh
source $XDG_CONFIG_HOME/zsh/plugins/kubectl.zsh
