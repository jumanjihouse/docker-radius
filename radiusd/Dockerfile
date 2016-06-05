FROM alpine:3.4

RUN apk add --no-cache freeradius openssl && \
    rm -f /etc/raddb/mods-enabled/eap && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
