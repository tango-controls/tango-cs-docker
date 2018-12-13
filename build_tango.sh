#!/bin/bash

source ./tango.properties

mkdir build

docker build --tag tango-build -f .travis/Dockerfile .

docker network rm tango-build-network

docker network create tango-build-network

docker run --name mysql --hostname mysql --network tango-build-network -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 -d mysql:5.6

MYSQL_HOST_IP=docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mysql

docker run --name tango-build --network tango-build-network -v `pwd`/build:/build -dit tango-build

docker exec tango-build ./configure --prefix=/build --disable-java --with-mysql-ho=$MYSQL_HOST_IP --with-mysql-admin=root --with-mysql-admin-passwd=root

docker exec tango-build make

docker exec tango-build make install

