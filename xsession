#!/bin/bash

# make sure dmenu knows about all our PATH trickery
. $HOME/.bashrc

# Load resources

xrdb -merge .Xresources

# set up Xmodmap

xmodmap .Xmodmap

# Set up an icon tray

trayer --edge top --align right --SetDockType true --SetPartialStrut false \
 --expand true --width 10 --transparent true --tint black --height 18 &

# Start clipboard manager
parcellite &

# Set the background image

feh --bg-fill $HOME/.xmonad/bg.jpg

# Fire up apps

xscreensaver -no-splash &

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/gnome-settings-daemon ] ; then
   gnome-settings-daemon &
fi


if [ -x /usr/bin/gnome-sound-applet ] ; then
   gnome-sound-applet &
fi

if [ -x /usr/bin/gnome-power-manager ] ; then
   gnome-power-manager &
fi

$HOME/code/resizR/src/resizR

$HOME/.dropbox-dist/dropboxd &
disown

# simple automounter
udisks-glue &

exec xmonad
