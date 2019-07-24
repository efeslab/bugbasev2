# patched commit 34e4604dbe445e03449aece98a32af70b42d8d71
# issue 229 metadump segfault
FROM debian:stretch
RUN apt-get update && apt-get install -y gcc wget git perl netcat make procps vim apt-src automake-1.15
RUN echo 'deb-src http://deb.debian.org/debian stretch main\n\
deb-src http://security.debian.org/debian-security stretch/updates main\n\
deb-src http://deb.debian.org/debian stretch-updates main' >> /etc/apt/sources.list
WORKDIR /tmp
RUN git clone https://github.com/memcached/mc-crusher.git
ARG version=1.4.33
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
RUN tar -zxf libevent-2.0.21-stable.tar.gz && rm libevent-2.0.21-stable.tar.gz
WORKDIR /tmp/memcached-$version/libevent-2.0.21-stable
RUN ./configure --disable-shared && make && make install
WORKDIR /tmp/memcached-$version
RUN ./configure LDFLAGS="-static -L/usr/local/lib -l:libevent_core.a" && make -j32 && make install
WORKDIR /tmp/mc-crusher
CMD ./bench-warmer 127.0.0.1:11211 key 1 1000000 && echo "lru_crawler metadump all" | nc 127.0.0.1 11211 & sleep 3 && pkill nc & memcached -p 11211 -u root -l 127.0.0.1 -m 56253 -C -c 100000 -o slab_chunk_max=524288 -o slab_reassign,slab_automove,lru_maintainer,lru_crawler,hash_algorithm=murmur3 -I 20m
