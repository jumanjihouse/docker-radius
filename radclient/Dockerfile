FROM alpine:3.4

ARG VERSION
RUN apk add --no-cache freeradius-radclient=${VERSION}
COPY test.conf /root/test.conf
COPY status_message /root/
ENTRYPOINT ["radclient"]
