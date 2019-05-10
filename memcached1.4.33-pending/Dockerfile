# segfault (null pointer dereference) during lru command handling
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
COPY ./telnet.sh /tmp/telnet.sh
WORKDIR /tmp
RUN chmod +x telnet.sh
CMD memcached -p 11211 -u root -l 127.0.0.1 -m 56253 -C -c 100000 -o slab_chunk_max=524288 -o slab_reassign,slab_automove,lru_maintainer,lru_crawler,hash_algorithm=murmur3 -I 20m & /bin/bash
