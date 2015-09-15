# tango-cs-docker

Minimal Docker image with *TANGO control system*
(http://www.tango-controls.org/).

![Build Status](https://img.shields.io/travis/mliszcz/tango-cs-docker.svg)

## Contents

The following packages are installed:

* mysql-server
* tango-db
* tango-starter
* tango-accesscontrol
* tango-test

## Quick start
To run the image:
```
docker run -d -p 10000:10000 mliszcz/tango-cs
```

By default, `TangoTest` device is started.
