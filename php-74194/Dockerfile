FROM debian:latest
RUN apt-get update && apt-get install -y build-essential libxml2 libxml2-dev
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y wget git vim
ARG VERSION=7.1.6
WORKDIR /tmp
RUN wget https://www.php.net/distributions/php-$VERSION.tar.gz
RUN tar -zxf php-$VERSION.tar.gz && rm php-$VERSION.tar.gz
WORKDIR /tmp/php-$VERSION
RUN ./configure CFLAGS="-O0 -g3" && make -j32 && make install
COPY poc.php data /tmp/
WORKDIR /tmp
CMD php -f poc.php data
