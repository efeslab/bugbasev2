#!/bin/bash

gdb --args klee -env-file=env -solver-backend=stp -call-solver=true -oracle-KTest=oracle.ktest -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -replay-path=klee-out-0/test000001.path -use-independent-solver=false -oob-check=false -allocate-determ ./sqlite3.bc --sym-stdin 201 --sym-file-stdin --concretize-cfg concretize.cfg
