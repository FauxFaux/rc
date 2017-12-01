#!/bin/sh
eval $(keychain --eval -q)
# disable mouse acceleration
xset m 0 0
xset dpms 590
xsetroot -solid grey17
xautolock -locker 'i3lock -c 303030' &
exec i3 2>&1 >> ~/.i3.log
