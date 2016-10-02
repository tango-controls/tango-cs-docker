# TANGO Control System Dockerfile

FROM centos:7
MAINTAINER mliszcz <liszcz.michal@gmail.com>

ADD scripts/maxiv.repo /etc/yum.repos.d/
ADD scripts/supervisord.conf /etc/supervisord.conf
ADD scripts/tango_register_device /usr/local/bin/
ADD scripts/wait-for-it.sh /usr/local/bin/

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

EXPOSE 10000

RUN useradd -ms /bin/bash tango

USER tango

CMD /usr/local/bin/wait-for-it.sh $MYSQL_HOST --timeout=30 --strict -- \
    /usr/bin/supervisord -c /etc/supervisord.conf
