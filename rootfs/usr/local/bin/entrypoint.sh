#!/bin/ash
  if [ -z "${1}" ]; then
    elevenLogJSON info "starting chrony"
    rm -f ${APP_ROOT}/run/chrony.pid
    set -- "chronyd" \
      -4 \
      -m \
      -L 0 \
      -f "${APP_ROOT}/etc/default.conf" \
      -d \
      -u docker \
      -U \
      -x

    # -4            Use IPv4 addresses only
    # -m            Lock memory
    # -L LEVEL      Set logging threshold (0)
    # -f FILE       Specify configuration file (/etc/chrony/chrony.conf)
    # -d            Don't run as daemon and log to stderr
    # -u USER       Specify user (chrony)
    # -U            Don't check for root
    # -x            Don't control clock
  fi

  exec "$@"