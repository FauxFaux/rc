#!/bin/zsh
set -eu

cat <<E
general {
    colors = true
    interval = 5
    output_format = "i3bar"
}
E

if [ "$(df -P / /home/faux | sed 1d | awk '{print $1}' | sort -u | wc -l)" -gt 1 ]; then
    echo 'order += "disk /home/faux"'
fi

LAPTOP=0
if [ -e /usr/sbin/laptop-detect ]; then
    if /usr/sbin/laptop-detect; then
        LAPTOP=1
    fi
fi

if [ $LAPTOP -eq 1 ]; then
   echo 'order += "battery 0"'
fi

echo 'order += "disk /"'

devices() {
    ip l | sed -En 's/^[0-9]+: (\w+):.*/\1/p'
}

eth=$(devices | egrep '^e' || true)

if ! [ -z "$eth" ]; then
    echo 'order += "ethernet '$eth\"
fi

wifi=$(iwconfig 2>/dev/null | head -n1 | awk '{print $1}')
if [ ! -z "$wifi" ]; then
    echo 'order += "wireless '$wifi\"
fi

cat <<E
order += "cpu_temperature 0"
order += "load"
order += "tztime day"
order += "tztime local"
order += "volume master"
E

if [ ! -z "$wifi" ]; then

    echo 'wireless '$wifi' {'

cat <<E
    format_up = "%quality %essid %ip"
    format_down = "W: down"
}
E
fi

echo "ethernet $eth {"

cat <<E
    format_up = "%ip"
    format_down = "E: down"
}

tztime day {
    format = "%a"
}

tztime local {
    format = "%Y-%m-%d %H:%M:%S"
}

load {
    format = "%1min %5min %15min"
}

cpu_temperature 0 {
    format = "%degrees°C"
E

echo 'path = "'$(echo /sys/devices/platform/coretemp.0/hwmon/hwmon*/temp1_input)\"

cat <<E
}

disk "/" {
    format = "%free"
}

disk "/home/faux" {
    format = "%free"
}

ipv6 {
    format_down = "no v6"
}

volume master {
    format = "♪: %volume"
    device = "default"
    mixer = "Master"
    mixer_idx = 0
}
E

if [ $LAPTOP -eq 1 ]; then
    cat <<E
battery 0 {
    format = "%status %percentage %remaining %consumption"
    integer_battery_capacity = true
    last_full_capacity = true
    threshold_type = "time"
    low_threshold = "30"
}
E
fi
