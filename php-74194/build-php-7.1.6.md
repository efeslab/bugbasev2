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

# record
```
klee -solver-backend=stp -call-solver=false -oracle-KTest=test21.ktest -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -env-file=php_env -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -use-independent-solver=false -oob-check=false -allocate-determ ./test.bc poc.php data
```

# replay
```
klee -solver-backend=stp -call-solver=false -oracle-KTest=test21.ktest -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -env-file=php_env -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -replay-path=klee-out-7/test000001.path -use-independent-solver=false -oob-check=false -allocate-determ ./test.bc poc.php data -sym-file poc.php 181 -sym-file data 1553 -concretize-cfg tmp0.cfg
```
