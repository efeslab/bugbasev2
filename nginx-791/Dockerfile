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
# OpenSSL
ARG OPENSSL_version=1.0.2r
WORKDIR /tmp
RUN wget http://www.openssl.org/source/openssl-$OPENSSL_version.tar.gz
RUN tar -zxf openssl-$OPENSSL_version.tar.gz && rm openssl-$OPENSSL_version.tar.gz
WORKDIR /tmp/openssl-$OPENSSL_version
RUN ./Configure linux-x86_64 && make && make install
WORKDIR /tmp
ARG version=1.9.4
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN ./configure --prefix=/usr --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error_log --pid-path=/run/nginx.pid --lock-path=/run/lock/nginx.lock --with-cc-opt='-g3 -O0 -I/usr/include' --with-ld-opt=-L/usr/libx32 --http-log-path=/var/log/nginx/access_log --with-file-aio --with-pcre --with-threads --without-http_memcached_module --without-http_scgi_module --without-http_ssi_module --without-http_split_clients_module --without-http_upstream_ip_hash_module --without-http_userid_module --without-http_uwsgi_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_spdy_module --with-http_stub_status_module --with-http_sub_module --with-http_realip_module --with-http_ssl_module --without-mail_imap_module --without-mail_pop3_module --without-mail_smtp_module --with-debug --with-openssl=../openssl-$OPENSSL_version
RUN make -j8 && make install
COPY ./nginx.conf /etc/nginx/nginx.conf
CMD /usr/sbin/nginx && curl 127.0.0.1:8080 ; tail /var/log/nginx/error_log
