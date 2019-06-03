FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y wget curl procps
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev
RUN apt-get update && apt-get install -y libssl1.0-dev
RUN apt-get update && apt-get install -y zlibc zlib1g zlib1g-dev
RUN apt-get update && apt-get install -y libkrb5-dev
WORKDIR /tmp
ARG version=1.14.1
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN ./configure --with-debug --with-cc-opt='-g3 -O0' --prefix=/etc/nginx --with-pcre-jit --with-http_stub_status_module --with-http_realip_module --with-http_flv_module --with-http_gzip_static_module --with-http_ssl_module --with-http_v2_module --with-stream
RUN make && make install
COPY ./nginx.conf /etc/nginx/conf/nginx.conf
COPY ./index.html /etc/nginx/html/index.html
CMD /etc/nginx/sbin/nginx && curl localhost/loc1.html ; tail /etc/nginx/logs/error.log 
