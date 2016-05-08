# tango-cs-docker

Minimal Docker image with *TANGO Control System*
(http://www.tango-controls.org/).

[![Build Status](https://img.shields.io/travis/mliszcz/tango-cs-docker.svg)](https://travis-ci.org/mliszcz/tango-cs-docker)


## Contents

The image is based on Ubuntu 16.04 and TANGO stack 9.2.2.

Following device servers are installed:

* DataBaseds
* Starter
* TangoAccessControl
* TangoTest

## Quick start

First, you need a working instance of TANGO database (with all relevant tables
created). Then, tell Docker to connect to that database:

```bash
docker run -it --rm --name tango_databaseds \
  -e ORB_PORT=10000 \
  -e TANGO_HOST=127.0.0.1:10000 \
  -e MYSQL_HOST=mysql_db:3306 -e MYSQL_USER=tango -e MYSQL_PASSWORD=tango -e MYSQL_DATABASE=tango_db \
  mliszcz/tango-cs:latest
```

Check the `.travis.yml` file to see how to set up a database inside a Docker
container.

## Acknowledgements

* Thanks [vishnubob](https://github.com/vishnubob) for the `wait-for-it.sh`
  script;
