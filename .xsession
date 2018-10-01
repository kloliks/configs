export LANG="ru_RU.UTF-8"
export LC_NUMERIC=C
export LC_COLLATE=C

export QT_STYLE_OVERRIDE="gtk"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export XDG_CONFIG_HOME="$HOME/.config"

export GOPATH="$HOME/gocode/"
export XCURSOR_THEME="Oxygen_Black"

#export __GL_YIELD="USLEEP"

#export JAVA_HOME="/opt/oracle-jdk-bin-1.8.0.112"
#export ANDROID_SWT="/usr/share/swt-3.7/lib/"

#xset m 1/8 0
#xset -dpms
xsetroot -cursor_name left_ptr
xinput --set-prop "Logitech USB-PS/2 Optical Mouse" 'Device Accel Constant Deceleration' 2

setxkbmap -option ctrl:swapcaps

${HOME}/tmp/loloswitcher_0_27/loloswitcher&


# feh -g "x963++61" --randomize --bg-center-max --no-fehbg ~/wallpapers/konochan
#feh -g "x1019++61" --randomize --bg-center-max --no-fehbg ~/wallpapers/konochan ~/wallpapers/deponia/
feh --randomize --bg-max --no-fehbg ~/wallpapers/*
#feh --randomize --bg-center-max --no-fehbg ~/wallpapers/konochan


#xcompmgr -F&
compton -b

# for intel cards
# compton -b --backend=glx

#/usr/bin/vmware-user

# deluge  &
# firefox &
# skype   &
# smplayer&


# (sleep 4; ~/.conkyrc/start.pl -r)&
#conky -c ~/.conkyrc/status_bar
(sleep 4; conky -d)&

#/usr/bin/openbox-session
/usr/bin/xmonad

# vim:ft=sh
