FROM alpine:3.19.0

RUN apk add --no-cache freeradius-radclient
COPY test.conf /root/test.conf
COPY status_message /root/
ENTRYPOINT ["radclient"]
