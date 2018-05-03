#!/bin/sh

if pgrep deadbeef; then
    deadbeef --toggle-pause
else
    if [ "$1" = "next" ]; then
        action=Next
    else
        action=PlayPause
    fi
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$action
fi
