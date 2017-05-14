## Overview

FreeRadius server based on Alpine Linux

Source: https://github.com/jumanjihouse/docker-radius

Docker Hub:

* https://registry.hub.docker.com/u/jumanjiman/radiusd/<br/>
  [![Download size](https://images.microbadger.com/badges/image/jumanjiman/radiusd.svg)](http://microbadger.com/images/jumanjiman/radiusd "View on microbadger.com")&nbsp;
  [![Version](https://images.microbadger.com/badges/version/jumanjiman/radiusd.svg)](http://microbadger.com/images/jumanjiman/radiusd "View on microbadger.com")&nbsp;
  [![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/radiusd.svg)](https://registry.hub.docker.com/u/jumanjiman/radiusd 'Docker Hub')&nbsp;
  [![Circle CI](https://circleci.com/gh/jumanjihouse/docker-radius.png?circle-token=40e83b6bf3ffb753c47c13397faa6bcec5cdd93e)](https://circleci.com/gh/jumanjihouse/docker-radius/tree/master 'View CI builds')

* https://registry.hub.docker.com/u/jumanjiman/radclient/<br/>
  [![Download size](https://images.microbadger.com/badges/image/jumanjiman/radclient.svg)](http://microbadger.com/images/jumanjiman/radclient "View on microbadger.com")&nbsp;
  [![Version](https://images.microbadger.com/badges/version/jumanjiman/radclient.svg)](http://microbadger.com/images/jumanjiman/radclient "View on microbadger.com")&nbsp;
  [![Docker Registry](https://img.shields.io/docker/pulls/jumanjiman/radclient.svg)](https://registry.hub.docker.com/u/jumanjiman/radclient 'Docker Hub')&nbsp;
  [![Circle CI](https://circleci.com/gh/jumanjihouse/docker-radius.png?circle-token=40e83b6bf3ffb753c47c13397faa6bcec5cdd93e)](https://circleci.com/gh/jumanjihouse/docker-radius/tree/master 'View CI builds')

Docker tags:

* optimistic: `latest`
* pessimistic: `${freeradius_version}-${build_date}-git-${hash}`


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
    ✓ radiusd responds to status message authenticator
    ✓ radiusd authenticates user from raddb
    ✓ radiusd container log is meaningful

    4 tests, 0 failures


License
-------

See [`LICENSE`](LICENSE) in this repo.
