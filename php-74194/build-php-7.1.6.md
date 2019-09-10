# under php source directory
- apply php-7.1.6.klee.patch
- CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit
- make
- extract-bc sapi/cli/php
# under bug directory
- opt -load ~/transforms/build/RmFabs/libLLVMRmFabs.so -rmfabs -o test.bc < php-7.1.6/sapi/cli/php.bc
- env USE_ZEND_ALLOC=0 ~/klee/build/bin/klee --libc=uclibc --posix-runtime test.bc -f poc.php data
