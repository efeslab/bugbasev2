FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y wget curl procps
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev
RUN apt-get update && apt-get install -y libssl-dev
RUN apt-get update && apt-get install -y zlibc zlib1g zlib1g-dev
RUN apt-get update && apt-get install -y libkrb5-dev
WORKDIR /tmp
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y nodejs
RUN ln -s /usr/bin/nodejs /usr/local/bin/node
RUN npm init -y
RUN npm install ws wscat
ARG version=1.4.4
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN ./configure --with-debug --with-cc-opt='-g3 -O0 -m64' --prefix=/etc/nginx
RUN make -j8 && make install
WORKDIR /tmp
COPY ./nginx.conf /etc/nginx/conf/nginx.conf
COPY ./server.js /tmp/server.js
CMD /etc/nginx/sbin/nginx && bash
