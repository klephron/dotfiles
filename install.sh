#!/bin/bash

pwd_dir=`pwd`
script_dir=`dirname "$0"`
config_dir=.config

for var in .gvimrc .tmux.conf .vim; do
  ln -sfn $pwd_dir/$script_dir/$var $HOME/$var
done

for var in alacritty broot gtk-3.0 htop kdeglobals mimeapps.list nvim plasmarc qimgv qt5ct rofi zathura zsh fzfrc awesome; do
  ln -sfn $pwd_dir/$script_dir/$config_dir/$var $HOME/.config/$var
done

echo "Installed."
