## Overview

FreeRadius server based on Alpine Linux

Source: https://github.com/jumanjihouse/docker-radius

Docker Hub:

* https://registry.hub.docker.com/u/jumanjiman/radiusd/<br/>
  [![](https://imagelayers.io/badge/jumanjiman/radiusd:latest.svg)](https://imagelayers.io/?images=jumanjiman/radiusd:latest 'View on imagelayers.io')
  [![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/radiusd.svg)](https://registry.hub.docker.com/u/jumanjiman/radiusd 'Docker Hub')&nbsp;
  [![Circle CI](https://circleci.com/gh/jumanjihouse/docker-radius.png?circle-token=40e83b6bf3ffb753c47c13397faa6bcec5cdd93e)](https://circleci.com/gh/jumanjihouse/docker-radius/tree/master 'View CI builds')

* https://registry.hub.docker.com/u/jumanjiman/radclient/<br/>
  [![](https://imagelayers.io/badge/jumanjiman/radclient:latest.svg)](https://imagelayers.io/?images=jumanjiman/radclient:latest 'View on imagelayers.io')
  [![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/radclient.svg)](https://registry.hub.docker.com/u/jumanjiman/radclient 'Docker Hub')&nbsp;
  [![Circle CI](https://circleci.com/gh/jumanjihouse/docker-radius.png?circle-token=40e83b6bf3ffb753c47c13397faa6bcec5cdd93e)](https://circleci.com/gh/jumanjihouse/docker-radius/tree/master 'View CI builds')

Docker tags:

* optimistic: `latest`
* pessimistic: `${build_date}-git-${hash}`


Usage
-----

Use this image (and the radius client) for testing other images, such as
https://github.com/jumanjiman/docker-duoauthproxy


Build and test
--------------

We use circleci to build, test, and publish the images to Docker hub.
We use [BATS](https://github.com/sstephenson/bats) to run the test harness.
Output from BATS resembles:

    ✓ radiusd container is running
    ✓ radiusd container has an ip address
    ✓ radiusd responds to status message authenticator
    ✓ radiusd authenticates user from raddb
    ✓ radiusd container log is meaningful

    5 tests, 0 failures


License
-------

See [`LICENSE`](LICENSE) in this repo.
