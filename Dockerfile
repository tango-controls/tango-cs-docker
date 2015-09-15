# TANGO control system Dockerfile

FROM ubuntu:trusty
MAINTAINER mliszcz <liszcz.michal@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    DB_ROOT_PASSWORD=secret \
    TANGO_ADMIN_PASSWORD=secret \
    TANGO_APP_PASSWORD=

# http://askubuntu.com/questions/365911/why-the-services-do-not-start-at-installation
RUN printf '#!/bin/sh\nexit 0\n' > /usr/sbin/policy-rc.d

RUN apt-get update && \
    apt-get install -y debconf-utils

RUN printf "\
  mysql-server mysql-server/root_password password ${DB_ROOT_PASSWORD}\n \
  mysql-server mysql-server/root_password_again password ${DB_ROOT_PASSWORD}\n \
  tango-common tango-common/tango-host string 127.0.0.1:10000\n \
  tango-db tango-db/dbconfig-install boolean true\n \
  tango-db tango-db/mysql/admin-pass password ${TANGO_ADMIN_PASSWORD}\n \
  tango-db tango-db/mysql/app-pass password ${TANGO_APP_PASSWORD}" \
    | debconf-set-selections

RUN apt-get update && \
    apt-get install -y  mysql-server

RUN service mysql start && \
    apt-get update && \
    apt-get install -y tango-db tango-accesscontrol tango-test

EXPOSE 10000

CMD service mysql start && \
    service tango-db start && \
    service tango-starter start && \
    service tango-accesscontrol start && \
    /usr/lib/tango/TangoTest test
