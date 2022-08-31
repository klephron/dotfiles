CONFIG=$XDG_CONFIG_HOME/zsh

source $CONFIG/aliases.zsh
source $CONFIG/completion.zsh
source $CONFIG/dirstack.zsh
source $CONFIG/history.zsh
source $CONFIG/plugins.zsh
source $CONFIG/setopt.zsh
# dep: completion
source $CONFIG/prompt.zsh
# dep: plugins completion
source $CONFIG/bindkeys.zsh
source $CONFIG/hooks.zsh
