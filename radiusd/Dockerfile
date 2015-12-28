FROM alpine:3.2

RUN apk add --update freeradius openssl && rm -f /var/cache/apk/* && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
