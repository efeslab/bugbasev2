FROM debian:latest
RUN apt-get update && apt-get install -y build-essential perl
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y linux-headers-$(dpkg --print-architecture)
RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev
RUN apt-get update && apt-get install -y libssl-dev
RUN apt-get update && apt-get install -y systemtap-sdt-dev
RUN apt-get update && apt-get install -y wget curl procps file
RUN apt-get update && apt-get install -y git vim
RUN apt-get update && apt-get install -y zlibc zlib1g zlib1g-dev
ARG OPENSSL_VERSION=1.0.2k
# OpenSSL
WORKDIR /tmp
RUN wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz
RUN tar -zxf openssl-$OPENSSL_VERSION.tar.gz && rm openssl-$OPENSSL_VERSION.tar.gz
WORKDIR /tmp/openssl-$OPENSSL_VERSION
RUN ./Configure linux-x86_64 && make && make install
WORKDIR /tmp
RUN wget https://openresty.org/download/openresty-1.13.6.1.tar.gz
RUN tar -zxf openresty-1.13.6.1.tar.gz && rm openresty-1.13.6.1.tar.gz
WORKDIR /tmp/openresty-1.13.6.1
RUN ./configure -j8 --prefix=/usr/local/openresty --with-openssl=../openssl-$OPENSSL_VERSION --with-cc-opt='-g3 -O0 -DNGX_LUA_ABORT_AT_PANIC -I/usr/local/openresty/zlib/include -I/usr/local/openresty/pcre/include -I/usr/local/openresty/openssl/include' --with-ld-opt='-Wl,-rpath,/usr/local/openresty/luajit/lib -L/usr/local/openresty/zlib/lib -L/usr/local/openresty/pcre/lib -L/usr/local/openresty/openssl/lib -Wl,-rpath,/usr/local/openresty/zlib/lib:/usr/local/openresty/pcre/lib:/usr/local/openresty/openssl/lib' --with-pcre-jit --with-stream --with-stream_ssl_module --with-http_v2_module --without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module --with-http_stub_status_module --with-http_realip_module --with-http_addition_module --with-http_auth_request_module --with-http_secure_link_module --with-http_random_index_module --with-http_gzip_static_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-threads --with-file-aio --with-dtrace-probes --with-stream --with-stream_ssl_module --with-http_ssl_module
RUN make -j8 && make install
WORKDIR /usr/local/openresty/nginx/conf
RUN wget https://support.cloudflare.com/hc/en-us/article_attachments/201243967/origin-pull-ca.pem
RUN /usr/local/ssl/bin/openssl req -nodes -x509 -newkey rsa:4096 -keyout cert.key -out cert.pem -days 365 -subj '/CN=localhost'
COPY ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
WORKDIR /usr/local/openresty/bin
CMD ./openresty && curl -k https://localhost ; tail /usr/local/openresty/nginx/logs/error.log
