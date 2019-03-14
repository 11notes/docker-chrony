# :: Header
FROM alpine:3.9

# :: Run
USER root
RUN apk --update add chrony \
    && mkdir -p /chrony/etc \
    && mkdir -p /chrony/log \
    && mkdir -p /chrony/var

ADD ./source/chrony.conf /chrony/etc
ADD ./source/entrypoint.sh /

# :: Volumes
VOLUME ["/chrony/etc", "/chrony/var", "/chrony/log"]

# :: Start
HEALTHCHECK --interval=60s --timeout=5s CMD chronyc tracking > /dev/null
CMD ["/entrypoint.sh"]