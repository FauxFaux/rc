#!/bin/sh
# hack? shouln't this come from gdm or something?
# without it, systemctl --user / gnome-terminal won't start
# export XDG_RUNTIME_DIR=/run/user/$(id -u)

eval $(keychain --eval -q)
exec sway

