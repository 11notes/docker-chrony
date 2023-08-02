# :: Header
  FROM 11notes/alpine:stable
  ENV APP_ROOT=/chrony
  ENV APP_VERSION=4.3-r4

# :: Run
  USER root

  # :: prepare image
    RUN set -ex; \
      mkdir -p ${APP_ROOT}/etc; \
      mkdir -p ${APP_ROOT}/run; \
      mkdir -p /run/chrony;

  # :: install application
    RUN set -ex; \
      apk --no-cache add \
        chrony=${APP_VERSION};

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
  HEALTHCHECK --interval=30s --timeout=10s CMD /usr/local/bin/healthcheck.sh

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]