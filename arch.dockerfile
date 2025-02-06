# :: Util
  FROM alpine AS util

  RUN set -ex; \
    apk --no-cache --update add \
      git; \
    git clone https://github.com/11notes/docker-util.git;
# :: Header
  FROM 11notes/alpine:stable

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}
    ENV APP_RC=-r0

  # :: multi-stage
    COPY --from=util /docker-util/src/ /usr/local/bin

  # :: Run
  USER root

  # :: install application
    RUN set -ex; \
      apk --no-cache --update add \
        chrony=${APP_VERSION}${APP_RC};

    RUN set -ex; \
      mkdir -p ${APP_ROOT}/etc; \
      mkdir -p ${APP_ROOT}/run; \
      mkdir -p /run/chrony;

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /run/chrony; \
      chmod 0770 /run/chrony;

# :: Volumes
  VOLUME ["${APP_ROOT}/etc", "${APP_ROOT}/var", "${APP_ROOT}/ssl"]

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
  USER docker