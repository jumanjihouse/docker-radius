FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.name="jumanjiman/radiusd" \
    org.label-schema.description="FreeRadius server useful as a base image or to test other services" \
    org.label-schema.url="https://github.com/jumanjihouse/docker-radius" \
    org.label-schema.vcs-url="https://github.com/jumanjihouse/docker-radius.git" \
    org.label-schema.docker.dockerfile="/radiusd/Dockerfile" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.version=${VERSION}


# Mysteriously, some files in /etc/raddb have incorrect ownership.
# Therefore we have to fix it up, and we have to do so
# in the same layer as the installation (on circleci).
RUN apk add --no-cache freeradius=${VERSION} openssl && \
    find /etc/raddb/ -exec chgrp -h radius {} + && \
    rm -f /etc/raddb/mods-enabled/eap && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
