#!/bin/sh
set -ex

# If you are on CoreOS or similar minimal OS,
# you do not have the `make' command.
# This simple script compensates for that.
#
# Note: We use `docker cp' instead of a volume mount
# to enable a person to build on a remote docker host.
# Example:
#
#   export DOCKER_HOST='tcp://192.168.254.162:2375'
#   ./make build

usage() {
  echo 'Usage: ./make [build|start|stop|clean|test]' >&2
  exit 1
}

stop() {
  docker rm -f radiusd.service       &> /dev/null || :
}

clean() {
  stop
  docker rmi jumanjiman/radiusd || :
  docker rmi jumanjiman/radclient || :
  docker images -q -f dangling=true | xargs docker rmi || :
}

build() {
  stop

  # Build app images that are used only for the test harness.
  docker build --rm -t jumanjiman/radclient radclient/

  # Build the app images.
  docker build --rm -t jumanjiman/radiusd radiusd/

  # Show image sizes.
  docker images | grep -e SIZE -e radiusd -e radclient
}

start() {
  stop

  # Start radiusd container.
  docker run -d \
    -t \
    -p 1812:1812/udp \
    -c 512 \
    -m 100m \
    --read-only \
    --name radiusd.service \
    jumanjiman/radiusd -f -l stdout

  docker ps -a | grep -e NAME -e radiusd
}

test() {
  # Check that radiusd is actually running.
  echo
  docker ps | grep radiusd.service
  echo
  radiusd_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' radiusd.service)
  echo radiusd is running on ${radiusd_ip}
  echo
  echo Check status of radiusd
  echo "Message-Authenticator = 0x00" | docker run -i jumanjiman/radclient ${radiusd_ip}:1812 status testing123 | tee /tmp/radius.out
  grep 'Received Access-Accept' /tmp/radius.out &> /dev/null
  echo
  echo Authenticate against radiusd
  docker run -t jumanjiman/radclient -f /root/test.conf ${radiusd_ip}:1812 auth testing123 | tee /tmp/auth.out
  grep 'Received Access-Accept' /tmp/auth.out &> /dev/null
  echo
  echo Check that radiusd logs are meaningful
  docker logs radiusd.service | tee /tmp/radiusd.log
  grep 'Ready to process requests' /tmp/radiusd.log &> /dev/null

  # If we're still alive, previous steps exited good.
  echo
  echo OK
}

main() {
  [ "x${1}" = "x" ] && usage || ${1}
}

main ${1}
