# patched commit 34e4604dbe445e03449aece98a32af70b42d8d71
# issue 229 metadump segfault
FROM debian:stretch
RUN apt-get update && apt-get install -y gcc wget git perl netcat make procps vim
RUN apt-get update && apt-get install -y libevent-dev
WORKDIR /tmp
ARG version=1.4.33
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make -j32 && make install
WORKDIR /tmp
RUN git clone https://github.com/memcached/mc-crusher.git
WORKDIR /tmp/mc-crusher
CMD ./bench-warmer 127.0.0.1:11211 key 1 1000000 && echo "lru_crawler metadump all" | nc 127.0.0.1 11211 & sleep 3 && pkill nc & memcached -p 11211 -u root -l 127.0.0.1 -m 56253 -C -c 100000 -o slab_chunk_max=524288 -o slab_reassign,slab_automove,lru_maintainer,lru_crawler,hash_algorithm=murmur3 -I 20m
