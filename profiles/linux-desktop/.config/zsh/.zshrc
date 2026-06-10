config=$XDG_CONFIG_HOME/zsh

source $config/bindkeys.zsh
source $config/completion.zsh
source $config/dirstack.zsh
source $config/history.zsh
source $config/prompt.zsh

# PLUGINS
if command -v fzf >/dev/null 2>&1; then
  source "$config/plugins/fzf.zsh"
fi

if command -v kind >/dev/null 2>&1; then
  source "$config/plugins/kind.zsh"
fi

if command -v kitty >/dev/null 2>&1 && [[ -n "$KITTY_WINDOW_ID" ]]; then
  source "$config/plugins/kitty-scrollback.zsh"
fi

if command -v kubectl >/dev/null 2>&1; then
  source "$config/plugins/kubectl.zsh"
fi

if command -v lxc >/dev/null 2>&1; then
  source "$config/plugins/lxd.zsh"
fi

if command -v minikube >/dev/null 2>&1; then
  source "$config/plugins/minikube.zsh"
fi

if command -v mise >/dev/null 2>&1; then
  source "$config/plugins/mise.zsh"
fi

if command -v yazi >/dev/null 2>&1; then
  source "$config/plugins/yazi.zsh"
fi

if command -v zoxide >/dev/null 2>&1; then
  source "$config/plugins/zoxide.zsh"
fi

if command -v /usr/bin/fnox >/dev/null 2>&1; then
  source "$config/plugins/usr-bin-fnox.zsh"
fi

source $config/hooks.zsh
source $config/definitions.zsh
