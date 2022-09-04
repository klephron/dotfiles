#!/bin/bash

PWD_DIR=`pwd`
SCRIPT_DIR=`dirname "$0"`
REP_ROOT=$(realpath -m $PWD_DIR/$SCRIPT_DIR)
REP_CONFIG=$(realpath -m $REP_ROOT/.config)
HOME_ROOT=$HOME
[[ -n "$XDG_CONFIG_HOME" ]] && HOME_CONFIG=$XDG_CONFIG_HOME || HOME_CONFIG=~/.config
APPS_ROOT='.gvimrc .vim'
APPS_CONFIG='swi-prolog alacritty broot gtk-3.0 htop kdeglobals mimeapps.list nvim plasmarc qimgv qt5ct rofi zathura zsh fzfrc awesome tmux'

for var in $APPS_ROOT; do
  src=$REP_ROOT/$var
  dist=$HOME_ROOT/$var
  if ! [ $src -ef $dist ]; then
    ln -sfn $src $dist
    echo "$dist -> $src"
  fi
done

for var in $APPS_CONFIG; do
  src=$REP_CONFIG/$var
  dist=$HOME_CONFIG/$var
  if ! [ $src -ef $dist ]; then
    ln -sfn $src $dist
    echo "$dist -> $src"
  fi
done
