[![Build Status](https://img.shields.io/travis/tango-controls/tango-cs-docker.svg)](https://travis-ci.org/tango-controls/tango-cs-docker)

# Supported tags and respective `Dockerfile` links

* [`9`, `latest` (*Dockerfile*)](https://github.com/tango-controls/tango-cs-docker/blob/master/Dockerfile)

# What is Tango Control System?

> Tango Control System is a free open source device-oriented controls toolkit
> for controlling any kind of hardware or software and building SCADA systems.

For more information please visit [www.tango-controls.org](http://www.tango-controls.org).

![logo](http://www.tango-controls.org/static/tango/img/logo_tangocontrols.png)

# How to use this image

First, you need a working instance of TANGO database (with all relevant tables
created). Then, tell Docker to connect to that database:

```console
docker run -it --rm --name tango_databaseds \
  -e ORB_PORT=10000 \
  -e TANGO_HOST=127.0.0.1:10000 \
  -e MYSQL_HOST=mysql_db:3306 \
  -e MYSQL_USER=tango \
  -e MYSQL_PASSWORD=tango \
  -e MYSQL_DATABASE=tango_db \
  tangocs/tango:latest
```

Check the `.travis.yml` file to see how to set up a database inside a Docker
container.

Following device servers are installed and started by default:

* DataBaseds
* Starter
* TangoAccessControl

# Acknowledgements

* Thanks [vishnubob](https://github.com/vishnubob) for the `wait-for-it.sh`
  script;
