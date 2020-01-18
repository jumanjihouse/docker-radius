FROM alpine:3.11.3

# Mysteriously, some files in /etc/raddb have incorrect ownership.
# Therefore we have to fix it up, and we have to do so
# in the same layer as the installation (on circleci).
RUN apk add --no-cache freeradius openssl && \
    find /etc/raddb/ -exec chgrp -h radius {} + && \
    rm -f /etc/raddb/mods-enabled/eap && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
