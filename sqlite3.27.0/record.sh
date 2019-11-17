#!/bin/bash

klee -env-file=env -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -pathrec-entry-point=__klee_posix_wrapped_main -ignore-posix-path=true -allocate-determ ./sqlite3.bc < test.sqlite
