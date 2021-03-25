# :: Header
    FROM alpine:3.13


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