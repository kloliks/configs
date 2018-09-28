#!/bin/sh

# xhost +localhost

export LANG="ru_RU.UTF-8"
export LC_NUMERIC=C
export LC_COLLATE=C

export QT_STYLE_OVERRIDE="gtk"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"

export GOPATH="$HOME/gocode/"
export XCURSOR_THEME="Oxygen_Black"

#export __GL_YIELD="USLEEP"

export JAVA_HOME="/opt/oracle-jdk-bin-1.8.0.112"

#export __GL_THREADED_OPTIMIZATIONS=1
# export XDG_MENU_PREFIX="gnome-"

# export ANDROID_SWT="/usr/share/swt-3.7/lib/"

xsetroot -cursor_name left_ptr
#xset m 2 100
xinput --set-prop "Logitech USB-PS/2 Optical Mouse" 'Device Accel Constant Deceleration' 2

/usr/bin/xscreensaver -nosplash&

#/usr/bin/xcompmgr -F&
compton -b --backend=glx

feh --no-fehbg --bg-max --randomize /home/data/wallpapers/*
#feh -g "x1016++63" --no-fehbg --bg-center-max --randomize /home/data/wallpapers/konochan
#feh -g "1024x768" --no-fehbg --bg-center-max --randomize /home/data/wallpapers/konochan


${HOME}/tmp/LoLoSwitcher/build/loloswitcher&

setxkbmap -option ctrl:swapcaps

(sleep 2; conky -c ~/.conkyrc/status_bar)&
/usr/bin/xmonad

#(cd $HOME/src/tech1; ./t1server-core2d --nvr)

# vim:ft=sh
