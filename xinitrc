#exec xfce4-session
xmodmap ~/.xmodmap
export GTK_RC_FILES=$HOME/.gtkrc-2.0
export GTK2_RC_FILES=$HOME/.gtkrc-2.0
exec i3
