# build php
CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit
extract-bc sapi/cli/php

# run php in klee
opt -load ~/transforms/build/RmFabs/libLLVMRmFabs.so -rmfabs -o test.bc < php-7.1.1/sapi/cli/php.bc
env USE_ZEND_ALLOC=0 ~/klee/build/bin/klee --libc=uclibc --posix-runtime test.bc 1.php
