FROM alpine:3.4

ARG VERSION

RUN apk add --no-cache freeradius=${VERSION} openssl && \
    rm -f /etc/raddb/mods-enabled/eap && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
