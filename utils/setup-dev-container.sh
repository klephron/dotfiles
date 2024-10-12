#!/bin/bash

set -e
set -x

# Install configuration
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
root_path=$parent_path/..

cd $root_path

. ./dev-container/.xdgenv

make install/dev-container

# Setup zsh
chsh -s $(which zsh) root

echo "emulate sh -c 'source /etc/profile'" >> /etc/zsh/zprofile

zsh
