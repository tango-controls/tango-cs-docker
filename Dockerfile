# TANGO Control System Dockerfile

FROM ubuntu:xenial
MAINTAINER mliszcz <liszcz.michal@gmail.com>

RUN echo "deb [trusted=yes] http://mliszcz.github.io/tango-cs-build/repository/ apt/" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    supervisor

RUN apt-get update && apt-get install -y \
    libmysqlclient20 \
    libomniorb4-1 \
    libzmq5 \
    libcos4-1

RUN apt-get update && apt-get install -y \
    libtango9 \
    libtango9-dev \
    tango9-tools \
    tango9-db \
    tango9-starter \
    tango9-accesscontrol \
    tango9-test

ENV LD_LIBRARY_PATH=/usr/local/lib

ADD scripts/supervisord.conf /etc/supervisord.conf
ADD scripts/tango_register_device /usr/local/bin/
ADD scripts/wait-for-it.sh /usr/local/bin/

ENV ORB_PORT=10000

EXPOSE 10000

RUN useradd -ms /bin/bash tango

USER tango

CMD /usr/local/bin/wait-for-it.sh $MYSQL_HOST --timeout=30 --strict -- \
    /usr/bin/supervisord -c /etc/supervisord.conf
