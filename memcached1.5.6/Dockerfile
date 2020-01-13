# segfault with invalid client credentials
FROM ubuntu:18.04

COPY ReproduceMemcachedSegfault-1.0-SNAPSHOT-shaded.jar /
COPY start.sh /
RUN apt-get update
RUN apt-get install -y apt-utils wget libevent-dev libsasl2-dev gcc make
# for make test
RUN apt-get install -y perl libmemcached-tools sasl2-bin software-properties-common
RUN apt install -y openjdk-8-jdk openjdk-8-jre
RUN mkdir -p /etc/sasl2

COPY memcached.conf /etc/sasl2

ARG version=1.5.6
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /memcached-$version
RUN ./configure --enable-sasl && make && make test && make install
WORKDIR /

CMD  bash start.sh


