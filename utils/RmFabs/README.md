KLEE does not support floating point well. We need to remove all floating point related intrinsic function calls.
Currently we need this pass for php.

1. cd build && cmake .. && make
2. remove fabs: opt -load xxx/libLLVMRmFabs.so -rmfabs -o php_nofabs.bc < xxx/php.bc
