CONFIG_BINDKEYS=$XDG_CONFIG_HOME/zsh/bindkeys.zsh

# PLUGINS
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

source /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#777777"
ZSH_AUTOSUGGEST_STRATEGY="history"

source /usr/local/share/zsh/site-functions/bd-zsh/bd.plugin.zsh

source /usr/share/fzf/key-bindings.zsh

source $CONFIG_BINDKEYS
