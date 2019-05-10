# segmentation fault on specially crafted packet
FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y wget
RUN apt-get update && apt-get install -y libevent-dev
RUN apt-get update && apt-get install -y perl
RUN apt-get update && apt-get install -y netcat
WORKDIR /tmp
ARG version=1.4.16
RUN wget https://www.memcached.org/files/memcached-$version.tar.gz
RUN tar -zxvf memcached-$version.tar.gz && rm memcached-$version.tar.gz
WORKDIR /tmp/memcached-$version
RUN ./configure && make && make test && make install
WORKDIR /tmp
COPY ./issue_192.t /tmp/issue_192.t
COPY ./lib /tmp/lib
RUN chmod +x issue_192.t
WORKDIR /tmp/memcached-$version/t
RUN chmod +x issue_192.t
CMD ./issue_192.t
