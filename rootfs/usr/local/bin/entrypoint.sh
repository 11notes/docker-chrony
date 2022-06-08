#!/bin/ash
if [ -z "$1" ]; then
    rm -f /run/chrony.pid
    set -- "chronyd" \
        -f "/etc/chrony/default.conf" \
        -d
fi

exec "$@"