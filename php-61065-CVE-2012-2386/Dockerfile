FROM debian:latest
RUN apt-get update && apt-get install -y build-essential libxml2 libxml2-dev
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y curl wget git vim
ARG VERSION=5.3.6
WORKDIR /tmp
RUN wget http://museum.php.net/php5/php-$VERSION.tar.gz
RUN tar -zxf php-$VERSION.tar.gz && rm php-$VERSION.tar.gz
WORKDIR /tmp/php-$VERSION
RUN curl -s https://mail.gnome.org/archives/xml/2012-August/txtbgxGXAvz4N.txt | patch -p0
RUN ./configure --enable-debug && make -j32 && make install
COPY poc.php poc.phar.tar /tmp/
WORKDIR /tmp
