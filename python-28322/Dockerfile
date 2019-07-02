FROM debian:latest
RUN apt-get update && apt-get install -y build-essential checkinstall
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y wget curl procps file
RUN apt-get update && apt-get install -y git vim mercurial
RUN echo 'deb-src http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list
RUN echo 'deb-src http://security.debian.org/debian-security stretch/updates main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian stretch-updates main' >> /etc/apt/sources.list
RUN apt-get update && apt-get build-dep -y python3.5
# Python
ARG VERSION=v3.5.2
WORKDIR /tmp
RUN git clone https://github.com/python/cpython.git
WORKDIR /tmp/cpython
RUN git checkout $VERSION
RUN ./configure --with-pydebug CFLAGS="-O0 -g3"
RUN make -s -j8 && make install
WORKDIR /tmp
COPY Py35_itertools.py /tmp/
CMD /usr/local/bin/python3.5 Py35_itertools.py
