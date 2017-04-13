#!/bin/sh

if pgrep deadbeef; then
    deadbeef --toggle-pause
else
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
fi
