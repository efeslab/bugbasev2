# issue 379
FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y libevent-dev
RUN apt-get update && apt-get install -y perl
RUN apt-get update && apt-get install -y netcat
WORKDIR /tmp
ARG version=1.4.33
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make && make test && make install
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y procps
RUN apt-get update && apt-get install -y expect
RUN apt-get update && apt-get install -y openjdk-8-jdk
COPY ./MemcachedCounter.java /tmp/MemcachedCounter.java	
WORKDIR /tmp
CMD memcached -p 11211 -u root -l 127.0.0.1 & /bin/bash
