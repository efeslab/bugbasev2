Record 10 input variables.
Execution Failed with message "KLEE: Cannot find symbolic array const_arr10 in KTest".

This is from "https://www.sqlite.org/src/info/4e8e4857d32d401f"
# build with klee
```
CC=wllvm ../configure --enable-debug --disable-readline --disable-threadsafe --disable-shared --enable-static
```
# reproduce the bug
```
./sqlite3 -init test.sqlite
```
