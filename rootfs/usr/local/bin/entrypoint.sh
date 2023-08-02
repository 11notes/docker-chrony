#!/bin/ash
  if [ -z "$1" ]; then
    rm -f /chrony/run/chrony.pid
    set -- "chronyd" \
      -m \
      -L 0 \
      -f "/chrony/etc/chrony.conf" \
      -d \
      -u docker \
      -U \
      -x
  fi

  exec "$@"