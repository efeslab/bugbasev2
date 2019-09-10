# under zlib source directory
- CC=wllvm ./configure --static --prefix=. --libdir=./lib --includedir=./include
- make && make install

# under libpng source directory
- CC=wllvm ./configure --enable-static --disable-shared --prefix=/home/slark/php-76041-klee/libpng-1.6.37 --with-zlib-prefix=../zlib-1.2.11
- make && make install

# under php source directory
- CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit --with-gd --with-png-dir=../libpng-1.6.37 --with-zlib-dir=../zlib-1.2.11
- make
- extract-bc sapi/cli/php

# under bug directory
- opt -load ~/transforms/build/RmFabs/libLLVMRmFabs.so -rmfabs -o test.bc < php-7.2.3/sapi/cli/php.bc
- env USE_ZEND_ALLOC=0 ~/klee/build/bin/klee --libc=uclibc --posix-runtime --disable-verify=true test.bc poc.php
