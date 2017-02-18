FROM alpine:3.5

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


RUN apk add --no-cache freeradius=${VERSION} openssl && \
    rm -f /etc/raddb/mods-enabled/eap && \
    echo '$INCLUDE /etc/raddb/users' >> /etc/raddb/mods-config/files/authorize

COPY . /
RUN /usr/sbin/harden.sh

USER radius
ENTRYPOINT ["/usr/sbin/radiusd"]
CMD ["-f"]
