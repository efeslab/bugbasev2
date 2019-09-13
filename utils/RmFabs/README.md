KLEE does not support floating point well. We need to remove all floating point related intrinsic function calls.
Currently we need this pass for php.

To build the path:
``cd build && cmake .. && make``

You can check if `llvm.fabs.fXX` is involved in the path of reproducing the bug by:
``opt -load xxx/libLLVMFabs.so -checkfabs -o php_checkfabs.bc < xxx/php.bc``

Or you can just safely remove `llvm.fabs.fXX` for all current php bugs.
``opt -load xxx/libLLVMRmFabs.so -rmfabs -o php_nofabs.bc < xxx/php.bc``
