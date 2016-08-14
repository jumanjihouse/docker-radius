#!/bin/bash
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
  docker build --rm \
    --build-arg BUILD_DATE=${BUILD_DATE} \
    --build-arg VCS_REF=${VCS_REF} \
    --build-arg VERSION=${VERSION} \
    -t jumanjiman/radclient radclient/

  # Build the app images.
  docker build --rm \
    --build-arg BUILD_DATE=${BUILD_DATE} \
    --build-arg VCS_REF=${VCS_REF} \
    --build-arg VERSION=${VERSION} \
    -t jumanjiman/radiusd radiusd/

  # Show image sizes.
  docker images | grep -e SIZE -e radiusd -e radclient
}

test() {
  bats test/test_*.bats
}

publish() {
  docker login -e ${mail} -u ${user} -p ${pass}
  # Create tags.
  docker tag jumanjiman/radiusd jumanjiman/radiusd:${TAG}
  docker tag jumanjiman/radclient jumanjiman/radclient:${TAG}
  # Push server.
  docker push jumanjiman/radiusd:${TAG}
  docker push jumanjiman/radiusd:latest
  # Push client.
  docker push jumanjiman/radclient:${TAG}
  docker push jumanjiman/radclient:latest
  docker logout
}

main() {
  . VARS
  [ "x${1}" = "x" ] && usage || ${1}
}

main ${1}
