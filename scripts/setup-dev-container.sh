#!/bin/bash

echo "export XDG_CONFIG_HOME=~/.config" >> ~/.profile
echo 'export ZDOTDIR=$XDG_CONFIG_HOME/zsh' >> ~/.profile
source ~/.profile
make install/dev-container
