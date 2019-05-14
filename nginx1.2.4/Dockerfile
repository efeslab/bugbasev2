# patch not specifies
# ticket 235
# worker process segmentation fault
FROM debian:latest
RUN apt-get update && apt-get install -y build-essential perl
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y wget curl procps file
RUN apt-get update && apt-get install -y git
RUN apt-get update && apt-get install -y zlibc zlib1g zlib1g-dev
ARG version=1.2.4
ARG PCRE_version=8.31
ARG OPENSSL_version=1.0.2r
# PCRE
WORKDIR /tmp
RUN wget https://ftp.pcre.org/pub/pcre/pcre-$PCRE_version.tar.gz
RUN tar -zxf pcre-$PCRE_version.tar.gz && rm pcre-$PCRE_version.tar.gz
WORKDIR /tmp/pcre-$PCRE_version
RUN ./configure && make && make install
# OpenSSL
WORKDIR /tmp
RUN wget http://www.openssl.org/source/openssl-$OPENSSL_version.tar.gz
RUN tar -zxf openssl-$OPENSSL_version.tar.gz && rm openssl-$OPENSSL_version.tar.gz
WORKDIR /tmp/openssl-$OPENSSL_version
RUN ./Configure linux-x86_64 && make && make install_sw
# NGINX
WORKDIR /tmp
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN ./configure --with-debug --prefix=/etc/nginx --with-openssl=../openssl-$OPENSSL_version --with-pcre=../pcre-$PCRE_version --with-pcre-jit --with-cc-opt='-g3 -O0 -DNGX_HAVE_ACCEPT4=1 -DNGX_HAVE_OPENAT=0 -I../ipp_7.0.6.293_intel64.git/include -I../libjpeg-turbo-1.2.1' --with-http_stub_status_module --with-http_realip_module --with-http_flv_module --with-http_gzip_static_module --with-http_ssl_module
RUN make && make install
COPY ./nginx.conf /etc/nginx/conf/nginx.conf
WORKDIR /etc/nginx
RUN /usr/local/ssl/bin/openssl req -nodes -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=localhost'
CMD /etc/nginx/sbin/nginx && /usr/local/ssl/bin/openssl s_client -connect 127.0.0.1:443 -no_ticket -servername test2 && cat /etc/nginx/logs/error.log
