#!/bin/sh
eval $(keychain --eval -q)
xset dpms 590
xsetroot -solid grey17
xautolock -locker 'i3lock -c 303030' &
exec i3
