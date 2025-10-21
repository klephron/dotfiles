#!/usr/bin/env bash

set -euo pipefail

root=$(git rev-parse --show-toplevel)
profile=${1:-"cli-dev"}
profile_dir="$root/profiles/${profile}"

cd $root

. $profile_dir/.xdgenv

make install/${profile}

if [[ -h "$HOME/.pprofile" ]]; then
  echo '. $HOME/.pprofile' >> $HOME/.profile
fi

if command -v sudo &> /dev/null; then
  sudo chsh -s $(which zsh) $(whoami)
else
  chsh -s $(which zsh) $(whoami)
fi

zsh
