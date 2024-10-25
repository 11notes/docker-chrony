#!/bin/ash
  if [ -z "${1}" ]; then
    elevenLogJSON info "starting ${APP_NAME} (${APP_VERSION})"
    set -- "chronyd" \
      -4 \
      -L 0 \
      -f "${APP_ROOT}/etc/default.conf" \
      -d \
      -u docker \
      -U \
      -x
  fi

  exec "$@"