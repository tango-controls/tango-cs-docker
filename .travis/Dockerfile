FROM debian:stretch

#install cppzmq
RUN apt-get update && apt-get install -y git build-essential cmake libzmq3-dev pkg-config

RUN git clone -b v4.2.2 https://github.com/zeromq/cppzmq.git cppzmq

RUN cmake -H/cppzmq -B/cppzmq/build  -DCMAKE_INSTALL_PREFIX=/usr

RUN make -C /cppzmq/build install

RUN apt-get update && apt-get install -y omniidl libomniorb4-dev libcos4-dev libomnithread3-dev mariadb-client libmariadbclient-dev