# build zlib from source
cd zlib-1.2.11
CC=wllvm ./configure --static --prefix=. --libdir=./lib --includedir=./include
make && make install

# build libpng from source
CC=wllvm ./configure --enable-static --disable-shared --prefix=/home/slark/php-76041-klee/libpng-1.6.37 --with-zlib-prefix=../zlib-1.2.11
make && make install

# build php
CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit --with-gd --with-png-dir=../libpng-1.6.37 --with-zlib-dir=../zlib-1.2.11
make

#run php
# env USE_ZEND_ALLOC=0 is important since ZEND_ALLOC requires mmap
# -disable-verify is a workaround of missing debug info
USE_ZEND_ALLOC=0 klee —disable-verify=true xxx
