FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL \
    org.label-schema.name="jumanjiman/radclient" \
    org.label-schema.description="FreeRadius client useful as a base image or to test other services" \
    org.label-schema.url="https://github.com/jumanjihouse/docker-radius" \
    org.label-schema.vcs-url="https://github.com/jumanjihouse/docker-radius.git" \
    org.label-schema.docker.dockerfile="/radclient/Dockerfile" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.vcs-ref=${VCS_REF} \
    org.label-schema.version=${VERSION}

RUN apk add --no-cache freeradius-radclient=${VERSION}
COPY test.conf /root/test.conf
COPY status_message /root/
ENTRYPOINT ["radclient"]
