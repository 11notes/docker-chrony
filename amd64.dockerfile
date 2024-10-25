# :: Util
  FROM alpine as util

  RUN set -ex; \
    apk add --no-cache \
      git; \
    git clone https://github.com/11notes/util.git;

# :: Header
  FROM 11notes/alpine:stable
  COPY --from=util /util/linux/shell/elevenLogJSON /usr/local/bin
  ENV APP_ROOT=/chrony
  ENV APP_NAME="chrony"
  ENV APP_VERSION=4.5-r0

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}/etc; \
      mkdir -p ${APP_ROOT}/run; \
      mkdir -p /run/chrony;

  # :: install application
    RUN set -ex; \
      apk --no-cache --update add \
        chrony=${APP_VERSION}; \
      apk --no-cache --update upgrade;

  # :: copy root filesystem changes and add execution rights to init scripts
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /run/chrony; \
      chmod 0770 /run/chrony;

# :: Monitor
  HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]