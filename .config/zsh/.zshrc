source $XDG_CONFIG_HOME/zsh/conf/aliases.zsh
source $XDG_CONFIG_HOME/zsh/conf/completion.zsh
source $XDG_CONFIG_HOME/zsh/conf/dirstack.zsh
source $XDG_CONFIG_HOME/zsh/conf/history.zsh
source $XDG_CONFIG_HOME/zsh/conf/plugins.zsh
source $XDG_CONFIG_HOME/zsh/conf/setopt.zsh
# dep: completion
source $XDG_CONFIG_HOME/zsh/conf/prompt.zsh
# dep: plugins completion
source $XDG_CONFIG_HOME/zsh/conf/bindkeys.zsh
source $XDG_CONFIG_HOME/zsh/conf/hooks.zsh

# TMUX
precmd() {
  if [[ -n "$TMUX" ]]; then
    tmux setenv "$(tmux display -p 'TMUX_PWD_#D')" "$PWD"
  fi
}

