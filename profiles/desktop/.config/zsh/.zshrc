config=$XDG_CONFIG_HOME/zsh

source $config/builtins/completion.zsh
source $config/builtins/dirstack.zsh
source $config/builtins/history.zsh
source $config/builtins/prompt.zsh

source $config/plugins/autosuggestions.zsh
source $config/plugins/fzf.zsh
source $config/plugins/kind.zsh
source $config/plugins/kubectl.zsh
source $config/plugins/mise.zsh
source $config/plugins/syntax-highlighting.zsh
source $config/plugins/yazi.zsh
source $config/plugins/zoxide.zsh

source $config/hooks.zsh
source $config/bindkeys.zsh
source $config/definitions.zsh
