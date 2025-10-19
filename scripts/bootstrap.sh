#!/usr/bin/env bash

set -euo pipefail

root=$(git rev-parse --show-toplevel)
profile=${1:-"cli-dev"}

cd $root

. $root/profiles/${profile}/.xdgenv

make install/${profile}

# Setup zsh for current user
echo "emulate sh -c 'source /etc/profile'" >> ~/.profile

if command -v sudo &> /dev/null; then
  sudo chsh -s $(which zsh) $(whoami)
else
  chsh -s $(which zsh) $(whoami)
fi

zsh
