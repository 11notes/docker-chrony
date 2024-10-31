#!/bin/ash
  if [ -z "${1}" ]; then
    set -- "chronyd" \
      -4 \
      -L 0 \
      -f "${APP_ROOT}/etc/default.conf" \
      -d \
      -u docker \
      -U \
      -x

    elevenDockerImageStart
  fi

  exec "$@"