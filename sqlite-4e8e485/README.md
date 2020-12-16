This is from "https://www.sqlite.org/src/info/4e8e4857d32d401f"
patch: "https://www.sqlite.org/src/info/440a7cda000164d3"
This version is confirmed to work well: "https://www.sqlite.org/src/info/440a7cda000164d3"
# build with klee
```
CC=wllvm ../configure --enable-debug --disable-readline --disable-threadsafe --disable-shared --enable-static
```
# reproduce the bug
```
./sqlite3 -init test.sqlite
```

## For new assertion during replay: apply `new_assertions.patch`
Note that this assertion comes directly from the bugfix patch. It disables
certain optimizations in a certain scenario. I directly assert the predicate of
that certain scenario without understanding why such optimizations are invalid.
