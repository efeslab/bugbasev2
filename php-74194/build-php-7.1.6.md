# build php
apply php-7.1.6.klee.patch
CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit
make
extract-bc sapi/cli/php
# run php in klee
# fabs is removed from bitcode as a workaround of lack of klee support
# env USE_ZEND_ALLOC=0 is important since ZEND_ALLOC requires mmap
opt -load ~/transforms/build/RmFabs/libLLVMRmFabs.so -rmfabs -o test.bc < php-7.1.6/sapi/cli/php.bc
env USE_ZEND_ALLOC=0 ~/klee/build/bin/klee --libc=uclibc --posix-runtime test.bc -f poc.php data
