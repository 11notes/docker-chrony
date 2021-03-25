# :: Builder
    FROM alpine AS builder
    ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
    RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . && mv qemu-3.0.0+resin-arm/qemu-arm-static .

# :: Header
    FROM arm32v7/alpine:3.13
    COPY --from=builder qemu-arm-static /usr/bin


# :: Run
    # :: prepare
        USER root

    # :: install
        RUN set -x; \
            apk --update --no-cache add \
                chrony=4.0-r1;

    # :: copy root filesystem changes
        COPY ./rootfs /
        RUN chmod +x /usr/local/bin/*


# :: Monitor
    HEALTHCHECK --interval=60s --timeout=5s CMD chronyc tracking > /dev/null


# :: Start
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    CMD ["chronyd", "-f", "/etc/chrony/chrony.conf", "-d"]