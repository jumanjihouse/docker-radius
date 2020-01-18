FROM alpine:3.11.3

RUN apk add --no-cache freeradius-radclient
COPY test.conf /root/test.conf
COPY status_message /root/
ENTRYPOINT ["radclient"]
