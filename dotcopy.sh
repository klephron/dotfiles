#!/bin/bash

rm -rf .config 2> /dev/null
mkdir -p .config

cp -r $XDG_CONFIG_HOME/alacritty/       .config
mkdir -p .config/awesome/
cp    $XDG_CONFIG_HOME/awesome/rc.lua   .config/awesome/
cp -r $XDG_CONFIG_HOME/broot/           .config/

cp -r $XDG_CONFIG_HOME/gtk-3.0/         .config/
cp -r $XDG_CONFIG_HOME/htop/            .config/
cp    $XDG_CONFIG_HOME/kdeglobals       .config/
cp    $XDG_CONFIG_HOME/mimeapps.list    .config/
cp -r $XDG_CONFIG_HOME/nvim/            .config/  2> /dev/null
cp    $XDG_CONFIG_HOME/plasmarc         .config/
cp -r $XDG_CONFIG_HOME/qimgv/           .config/
cp -r $XDG_CONFIG_HOME/qt5ct/           .config/
cp -r $XDG_CONFIG_HOME/rofi/            .config/
cp -r $XDG_CONFIG_HOME/zathura/         .config/
cp -r $XDG_CONFIG_HOME/zsh/             .config/
cp    $XDG_CONFIG_HOME/mimeapps.list    .config/

cp    $HOME/.gvimrc                     .
cp    $HOME/.tmux.conf                  .

