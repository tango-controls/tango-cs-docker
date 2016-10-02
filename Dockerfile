# TANGO Control System Dockerfile

FROM centos:7
MAINTAINER https://github.com/tango-controls/tango-cs-docker/graphs/contributors

ADD resources/maxiv.repo /etc/yum.repos.d/
ADD resources/supervisord.conf /etc/supervisord.conf
ADD resources/tango_register_device /usr/local/bin/
ADD resources/wait-for-it.sh /usr/local/bin/

RUN yum -y install epel-release \
 && yum -y install supervisor zeromq \
 && yum-config-manager --save --setopt=epel.includepkgs="zeromq libsodium openpgm" \
 && yum -y install \
    libtango9 \
    tango-common \
    tango-admin \
    tango-starter \
    tango-db \
    tango-accesscontrol \
    tango-test \
 && rpm -e --nodeps mariadb mariadb-server \
 && rpm -qa 'perl*' | xargs rpm -e --nodeps

ENV ORB_PORT=10000
ENV TANGO_HOST=127.0.0.1:${ORB_PORT}

EXPOSE ${ORB_PORT}

RUN useradd -ms /bin/bash tango
USER tango

CMD /usr/local/bin/wait-for-it.sh $MYSQL_HOST --timeout=30 --strict -- \
    /usr/bin/supervisord -c /etc/supervisord.conf
