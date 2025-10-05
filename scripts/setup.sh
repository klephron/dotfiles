#!/usr/bin/env bash

set -euo pipefail

PROFILE=cli-dev

root=$(git rev-parse --show-toplevel)

cd $root

. $root/profiles/${PROFILE}/.xdgenv

make install/${PROFILE}

# Setup zsh for current user
echo "emulate sh -c 'source /etc/profile'" >> ~/.profile

if command -v sudo &> /dev/null; then
  sudo chsh -s $(which zsh) $(whoami)
else
  chsh -s $(which zsh) $(whoami)
fi

zsh
