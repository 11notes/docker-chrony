# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
  # GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      BUILD_ROOT="/chrony" \
      BUILD_BIN="/chrony/chronyd /chrony/chronyc"

  # :: FOREIGN IMAGES
  FROM 11notes/distroless AS distroless
  FROM 11notes/util AS util

# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
  FROM alpine AS build
  COPY --from=util /usr/local/bin /usr/local/bin

  ARG TARGETPLATFORM \
      TARGETOS \
      TARGETARCH \
      TARGETVARIANT \
      APP_VERSION \
      APP_UID \
      BUILD_ROOT \
      BUILD_BIN

  RUN set -ex; \
    apk add --update --no-cache \
      musl-dev \
      git \
      clang \
      bison \
      linux-headers \
      pps-tools-dev \
      pkgconf-dev \
      nettle-dev \
      gnutls-dev \
      upx \
      build-base;

  RUN set -ex; \
    git clone https://gitlab.com/chrony/chrony.git -b ${APP_VERSION};

  RUN set -ex; \
    cd ${BUILD_ROOT}; \
    LDFLAGS="-static" PKG_CONFIG="pkg-config --static" \
      ./configure \
        --with-user=docker \
        --chronyrundir=/run/chrony \
        --without-tomcrypt \
        --disable-readline \
        --without-editline \
        --without-seccomp \
        --without-libcap \
        --enable-scfilter \
        --enable-ntp-signd \
        --with-pidfile=/run/chrony/chrony.pid; \
    make -s -j $(nproc) LDFLAGS="-static";

  RUN set -ex; \
    mkdir -p /distroless/usr/local/bin; \
    for BIN in ${BUILD_BIN}; do \
      eleven checkStatic ${BIN}; \
      eleven strip ${BIN}; \
      cp ${BIN} /distroless/usr/local/bin; \
    done;

# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
  # :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless / /
    COPY --from=build /distroless/ /
    COPY --chown=${APP_UID}:${APP_GID} ./rootfs /

# :: PERSISTENT DATA
  VOLUME ["${APP_ROOT}/etc"]

# :: HEALTH
  HEALTHCHECK --interval=5s --timeout=2s --start-interval=5s \
    CMD ["/usr/local/bin/chronyc", "tracking", ">", "/dev/null"]

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/chronyd"]
  CMD ["-4", "-L", "0", "-f", "/chrony/etc/default.conf", "-d", "-u", "docker", "-U", "-x"]