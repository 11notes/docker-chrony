# :: Header
FROM alpine:3.10

# :: Run
USER root
RUN apk --update add chrony \
    && mkdir -p /chrony/etc \
    && mkdir -p /chrony/log

ADD ./source/chrony.conf /chrony/etc
ADD ./source/entrypoint.sh /

RUN chmod +x /entrypoint.sh

# :: Version
RUN echo "CI/CD{{$(chronyc --version 2>&1)}}"

# :: Volumes
VOLUME ["/chrony/etc", "/chrony/log"]

# :: Start
HEALTHCHECK --interval=60s --timeout=5s CMD chronyc tracking > /dev/null
CMD ["/entrypoint.sh"]