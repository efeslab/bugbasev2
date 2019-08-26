FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb wget git vim
WORKDIR /tmp
ARG VERSION=7.1.6
RUN wget https://www.php.net/distributions/php-$VERSION.tar.gz
RUN tar -zxf php-$VERSION.tar.gz && rm php-$VERSION.tar.gz
WORKDIR /tmp/php-$VERSION
RUN ./configure --disable-all CFLAGS="-O0 -g3" && make -j32 && make install
COPY poc.php data /tmp/
WORKDIR /tmp
CMD php -f poc.php data
