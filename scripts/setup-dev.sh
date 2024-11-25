#!/bin/bash

set -e
set -x

# Install configuration
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
root_path=$parent_path/..

cd $root_path

. ./dev/.xdgenv

make install/dev

# Setup zsh for current user
echo "emulate sh -c 'source /etc/profile'" >> ~/.profile

if command -v sudo &> /dev/null; then
  sudo chsh -s $(which zsh) $(whoami)
else
  chsh -s $(which zsh) $(whoami)
fi

zsh
