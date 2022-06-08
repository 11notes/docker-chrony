# :: Header
    FROM alpine:3.16

# :: Run
    # :: prepare
        USER root

    # :: install
        RUN set -x; \
            apk --update --no-cache add \
                chrony>=4.2-r0;

    # :: copy root filesystem changes
        COPY ./rootfs /

# :: Monitor
    RUN set -ex; chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK --interval=10s --timeout=2s CMD /usr/local/bin/healthcheck.sh

# :: Start
    RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]