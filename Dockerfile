ARG TANGO_VER=9.3.3-rc1
FROM tangocs/tango-libs:${TANGO_VER}
MAINTAINER info@tango-controls.org

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends supervisor

COPY resources/tango_register_device /usr/local/bin/
#ensure include conf.d
COPY resources/supervisord.conf      /etc/supervisord.conf
#copy tango cs conf
COPY resources/tango-db.conf      /etc/supervisor/conf.d
COPY resources/tango-starter.conf /etc/supervisor/conf.d
COPY resources/tango-access-control.conf /etc/supervisor/conf.d


ENV LD_LIBRARY_PATH=/usr/local/lib
ENV ORB_PORT=10000
ENV TANGO_HOST=127.0.0.1:${ORB_PORT}

EXPOSE ${ORB_PORT}

RUN useradd --create-home --home-dir /home/tango tango

RUN echo "tango ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/tango \
    && chmod 0440 /etc/sudoers.d/tango

USER tango

ENTRYPOINT /usr/local/bin/wait-for-it.sh $MYSQL_HOST --timeout=30 --strict -- \
    /usr/bin/supervisord -c /etc/supervisord.conf
