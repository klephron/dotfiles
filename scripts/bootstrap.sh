#!/usr/bin/env bash

set -euo pipefail

root=$(git rev-parse --show-toplevel)

profile=${1:-"cli-dev"}
profile_dir="$root/profiles/${profile}"

. $profile_dir/.xdgenv

make install/${profile}

# add $cmd to the first line of $HOME/.profile file
if [[ -h "$HOME/.pprofile" ]]; then
  h_profile="$HOME/.profile"
  cmd='. $HOME/.pprofile'

  if [[ -s "$h_profile" ]]; then
    grep -qxF "$cmd" "$h_profile" || sed -i "1i$cmd" "$h_profile"
  else
    echo "$cmd" > "$h_profile"
  fi
fi

# set zsh as login shell
if command -v sudo &> /dev/null; then
  sudo chsh -s $(which zsh) $(whoami)
else
  chsh -s $(which zsh) $(whoami)
fi

$(which zsh)
