FROM debian:jessie

MAINTAINER info@tango-controls.org

ARG TANGO_LIB_VER

ARG TANGO_SOURCE_DISTRIBUTION_VER

RUN apt-get update && apt-get install -y wget build-essential omniidl libomniorb4-dev libcos4-dev libomnithread3-dev libzmq3-dev mysql-client libmysqlclient-dev

RUN wget https://github.com/tango-controls/TangoSourceDistribution/releases/download/${TANGO_SOURCE_DISTRIBUTION_VER}/tango-${TANGO_SOURCE_DISTRIBUTION_VER}.tar.gz

RUN tar zxvf tango-${TANGO_SOURCE_DISTRIBUTION_VER}.tar.gz

WORKDIR tango-${TANGO_LIB_VER}