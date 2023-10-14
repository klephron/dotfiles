CONFIG=$XDG_CONFIG_HOME/zsh

source $CONFIG/aliases.zsh
source $CONFIG/completion.zsh
source $CONFIG/dirstack.zsh
source $CONFIG/history.zsh
source $CONFIG/plugins.zsh
# dep: completion
source $CONFIG/prompt.zsh
# dep: plugins completion
source $CONFIG/bindkeys.zsh
source $CONFIG/hooks.zsh
source $CONFIG/functions.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/nikit/Apps/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/nikit/Apps/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/nikit/Apps/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/nikit/Apps/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
