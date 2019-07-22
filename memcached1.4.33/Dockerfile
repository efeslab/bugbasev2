# patched commit 34e4604dbe445e03449aece98a32af70b42d8d71
# issue 229 metadump segfault
FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y libevent-dev
RUN apt-get update && apt-get install -y perl
RUN apt-get update && apt-get install -y netcat
WORKDIR /tmp
ARG version=1.4.33
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make && make install
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y procps
WORKDIR /tmp
RUN apt-get update && apt-get install -y git	
RUN git clone https://github.com/memcached/mc-crusher.git
WORKDIR /tmp/mc-crusher
CMD sleep 1 && ./bench-warmer 127.0.0.1:11211 key 1 1000000 && echo "lru_crawler metadump all" | nc 127.0.0.1 11211 & sleep 3 && pkill nc & memcached -p 11211 -u root -l 127.0.0.1 -m 56253 -C -c 100000 -o slab_chunk_max=524288 -o slab_reassign,slab_automove,lru_maintainer,lru_crawler,hash_algorithm=murmur3 -I 20m
