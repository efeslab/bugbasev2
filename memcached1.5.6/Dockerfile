# segfault with invalid client credentials
FROM ubuntu:18.04

COPY ReproduceMemcachedSegfault-1.0-SNAPSHOT-shaded.jar /

RUN apt-get update
RUN apt-get install -y wget libevent-dev libsasl2-dev gcc make 
ARG version=1.5.6


