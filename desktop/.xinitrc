#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# setup for multiple monitors (96:laptop / 144:dual)
is_dual=$(xrandr --listactivemonitors | grep 'DisplayPort-0')

if [[ $is_dual != "" ]]
then
  sed -i -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources
  xrdb ~/.Xresources
  autorandr --load "1080-1.25_2160"
  # fix mouse cursor blinking
  # xrandr --output DisplayPort-0 --scale 0.99996x0.99996 --filter nearest
else
  sed -i -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources
  xrdb ~/.Xresources
  autorandr --load "1080"
fi

xrandr --output eDP --filter bilinear

# Network manager applet
exec nm-applet &

exec lxpolkit &

# Composition manager
exec picom &

# Greenclip
exec greenclip daemon &

# Clipmenu
# exec clipmenud &

# Awesome window manager (with disabled opacity)
exec awesome --no-argb &
systemctl --user start graphical-session-manager.target
wait $!
systemctl --user stop graphical-session-manager.target
