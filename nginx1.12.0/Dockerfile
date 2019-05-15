# patch not specifies
# ticket 1263
# worker process segmentation fault
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
ARG version=1.12.0
RUN wget https://nginx.org/download/nginx-$version.tar.gz
RUN tar -zxf nginx-$version.tar.gz && rm nginx-$version.tar.gz
WORKDIR /tmp/nginx-$version
RUN git clone https://github.com/stnoonan/spnego-http-auth-nginx-module.git
RUN ./configure --with-cc-opt='-O2 -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' --add-module=spnego-http-auth-nginx-module --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-mail --with-mail_ssl_module --with-http_v2_module --with-threads --with-http_slice_module --prefix=/etc/nginx
RUN make && make install
COPY ./nginx.conf /etc/nginx/conf/nginx.conf
COPY ./loc1.html /etc/nginx/html/loc1.html
COPY ./loc2.html /etc/nginx/html/loc2.html
CMD /etc/nginx/sbin/nginx && curl localhost/loc1.html ; tail /etc/nginx/logs/error.log 
