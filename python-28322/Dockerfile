FROM debian:latest
RUN apt-get update && apt-get install -y build-essential checkinstall
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y wget curl procps file
RUN apt-get update && apt-get install -y git vim
RUN apt-get update && apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
# OpenSSL
ARG OPENSSL_VERSION=1.0.2
WORKDIR /tmp
RUN wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
RUN tar -zxf openssl-$OPENSSL_VERSION.tar.gz && rm openssl-$OPENSSL_VERSION.tar.gz
WORKDIR /tmp/openssl-$OPENSSL_VERSION
RUN ./config shared --prefix=/usr/local/ && make && make install
ENV LDFLAGS="-L/usr/local/lib/"
ENV LD_LIBRARY_PATH="/usr/local/lib/"
ENV CPPFLAGS="-I/usr/local/include -I/usr/local/include/openssl"
ARG VERSION=3.5.2
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
RUN tar xzf Python-$VERSION.tgz && rm Python-$VERSION.tgz
WORKDIR /tmp/Python-$VERSION
RUN ./configure --prefix=/usr/local/ && make -j8 && make install
COPY Py35_itertools.py /tmp/
