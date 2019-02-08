[![Build Status](https://img.shields.io/travis/tango-controls/tango-cs-docker.svg)](https://travis-ci.org/tango-controls/tango-cs-docker)

# Supported tags and respective `Dockerfile` links

* [`9`, `latest` (*Dockerfile*)](https://github.com/tango-controls/tango-cs-docker/blob/master/Dockerfile)

# What is Tango Control System?

> Tango Control System is a free open source device-oriented controls toolkit
> for controlling any kind of hardware or software and building SCADA systems.

For more information please visit [www.tango-controls.org](http://www.tango-controls.org).

![logo](http://www.tango-controls.org/static/tango/img/logo_tangocontrols.png)

# How to use this image using docker

First, you need a working instance of TANGO database (with all relevant tables
created). Then, tell Docker to connect to that database:

```console
docker run -it --rm --name tango_databaseds \
  -e ORB_PORT=10000 \
  -e TANGO_HOST=127.0.0.1:10000 \
  -e MYSQL_HOST=mysql_db:3306 \
  -e MYSQL_USER=tango \
  -e MYSQL_PASSWORD=tango \
  -e MYSQL_DATABASE=tango \
  tangocs/tango-cs:latest
```

Check the `.travis.yml` file to see how to set up a database inside a Docker
container.

Following device servers are installed and started by default:

* DataBaseds
* Starter
* TangoAccessControl

# How to use this image using docker-compose

Create a docker-compose.yml file 

**NOTE** the docker-compose provided below also includes TangoTest device

**NOTE** please pay attention to docker-compose versioning - it depends on the docker engine version: [see docker docs](https://docs.docker.com/compose/compose-file/)

```yaml
version: '3.7'
services:
  tango-db:
    image: tangocs/mysql:9.2.2
    ports:
     - "9999:3306"
    environment:
     - MYSQL_ROOT_PASSWORD=root
  tango-cs:
    image: tangocs/tango-cs:9.3.2-alpha.1-no-tango-test
    ports:
     - "10000:10000"
    environment:
     - TANGO_HOST=localhost:10000
     - MYSQL_HOST=tango-db:3306
     - MYSQL_USER=tango
     - MYSQL_PASSWORD=tango
     - MYSQL_DATABASE=tango
    links:
     - "tango-db:localhost"
    depends_on:
     - tango-db
  tango-test:
    image: tangocs/tango-test:latest
    environment:
     - TANGO_HOST=tango-cs:10000
    links:
     - "tango-cs:localhost"
    depends_on:
     - tango-cs
```

Run `docker-compose up`. Tango Controls System will be available through `localhost:10000`

# Acknowledgements

* Thanks [vishnubob](https://github.com/vishnubob) for the `wait-for-it.sh`
  script;
