FROM alpine:3.24.4

RUN apk add --no-cache freeradius-radclient
COPY test.conf /root/test.conf
COPY status_message /root/
ENTRYPOINT ["radclient"]
