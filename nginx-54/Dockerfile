FROM debian:latest
RUN apt-get update && apt-get install -y build-essential perl
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev
RUN apt-get update && apt-get install -y libssl-dev libxslt1-dev
RUN apt-get update && apt-get install -y systemtap-sdt-dev
RUN apt-get update && apt-get install -y wget curl procps file
RUN apt-get update && apt-get install -y git vim
RUN apt-get update && apt-get install -y zlibc zlib1g zlib1g-dev
ARG OPENSSL_VERSION=1.0.2q
# OpenSSL
WORKDIR /tmp
RUN wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
RUN tar -zxf openssl-$OPENSSL_VERSION.tar.gz && rm openssl-$OPENSSL_VERSION.tar.gz
WORKDIR /tmp/openssl-$OPENSSL_VERSION
RUN ./Configure linux-x86_64 && make && make install
WORKDIR /tmp
ARG version=1.0.9
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN ./configure --with-debug --with-cc-opt='-g3 -O0 -I /usr/local/include' --with-ld-opt='-L /usr/local/lib' --prefix=/etc/nginx --conf-path=/etc/nginx/nginx.conf --with-openssl=../openssl-$OPENSSL_VERSION --with-file-aio --with-ipv6 --with-http_flv_module --with-http_gzip_static_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_xslt_module --with-pcre --http-client-body-temp-path=/var/tmp/nginx/client_body_temp --http-fastcgi-temp-path=/var/tmp/nginx/fastcgi_temp --http-proxy-temp-path=/var/tmp/nginx/proxy_temp --http-scgi-temp-path=/var/tmp/nginx/scgi_temp --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi_temp
RUN make -j8 && make install
WORKDIR /etc/nginx
RUN /usr/local/ssl/bin/openssl genrsa -out server.key 2048
RUN /usr/local/ssl/bin/openssl req -key server.key -new -x509 -days 365 -out vps.crt -subj '/CN=vps'
RUN /usr/local/ssl/bin/openssl req -key server.key -new -x509 -days 365 -out website.crt -subj '/CN=website'
RUN mkdir -p /var/tmp/nginx/fastcgi_cache_website
RUN mkdir -p /home/website/tmp/client_body_temp
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./website.conf /etc/nginx/sites-enabled/website.conf
COPY ./index.php /etc/nginx/html/index.php
CMD /etc/nginx/sbin/nginx && curl https://website.com.ua ; tail /etc/nginx/logs/error.log
