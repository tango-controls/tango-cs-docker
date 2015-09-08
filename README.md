# tango-cs-docker

Minimal Docker image with
[TANGO control system](http://www.tango-controls.org/).

## Contents

The following packages are installed:

* mysql-server
* tango-db
* tango-starter
* tango-test

## Quick start
To run the image:
```
docker run -d -p 10000:10000 mliszcz/tango-cs
```

To get the IP address:
```
docker inspect -f '{{ .NetworkSettings.IPAddress }}' <container-id>
```

By default, `TangoTest` device is started.
