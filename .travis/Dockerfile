FROM debian:jessie

MAINTAINER info@tango-controls.org

#ARG=<tango lib ver>

RUN apt-get update && apt-get install -y build-essential cmake autoconf libtool ant omniidl libomniorb4-dev libcos4-dev libomnithread3-dev libzmq3-dev

RUN wget https://github.com/tango-controls/TangoSourceDistribution/releases/download/9.3.2-alpha.1/tango-9.3.2-alpha.1.tar.gz

RUN tar zxvf tango-9.3.2-alpha.1.tar.gz

WORKDIR tango-9.3.2

