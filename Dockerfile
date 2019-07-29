# TANGO Control System Dockerfile

FROM debian:stretch
MAINTAINER info@tango-controls.org

RUN apt-get update && apt-get install -y supervisor omniidl libomniorb4-dev libcos4-dev libomnithread3-dev libzmq3-dev libmysqlclient-dev openjdk-8-jre-headless

COPY build/bin/*                     /usr/bin/
COPY resources/tango_register_device /usr/local/bin/
COPY resources/wait-for-it.sh        /usr/local/bin/
COPY resources/supervisord.conf      /etc/supervisord.conf

COPY build/lib/* /usr/local/lib/

ENV LD_LIBRARY_PATH=/usr/local/lib
ENV ORB_PORT=10000
ENV TANGO_HOST=127.0.0.1:${ORB_PORT}

EXPOSE ${ORB_PORT}

RUN useradd -ms /bin/bash tango
USER tango

CMD /usr/local/bin/wait-for-it.sh $MYSQL_HOST --timeout=30 --strict -- \
    /usr/bin/supervisord -c /etc/supervisord.conf
