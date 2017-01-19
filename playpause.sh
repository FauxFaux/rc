#!/bin/sh

if PID=$(pgrep --oldest mplayer); then
    if [ "T" = "$(cut -d' ' -f 3 /proc/${PID}/stat)" ]; then
        SIG=CONT
    else
        SIG=STOP
    fi
    kill -${SIG} $PID
elif pgrep deadbeef; then
    deadbeef --toggle-pause
else
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
fi
