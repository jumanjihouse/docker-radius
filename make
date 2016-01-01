#!/bin/sh
set -e

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

test() {
  bats test/test_*.bats
}

main() {
  [ "x${1}" = "x" ] && usage || ${1}
}

main ${1}
