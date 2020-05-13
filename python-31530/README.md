# Python
[buggy commit snapshot](https://github.com/python/cpython/commit/1bce4efdb4624561adce62e544dbe20ec2627ae2)

[POC](https://bugs.python.org/file47156/readahead.py)

[patch](https://bugs.python.org/file47157/0001-stop-crashes-when-iterating-over-a-file-on-multiple-.patch)

## Build
I followed the [wiki](https://wiki.python.org/moin/BuildStatically) to build
python statically.
```
mkdir build
cd build
CC=wllvm ../configure --disable-profiling --disable-optimizations --disable-toolbox-glue --disable-ipv6 --disable-big-digits --without-valgrind --without-tsc --without-gcc LDFLAGS='-Wl,-no-export-dynamic -static' LINKFORSHARED=" " --disable-shared
# after configure, you need to add a Modules/Setup.local to specify which
# Module to compile statically. It is modified from Modules/Setup
cp ../../Setup.local Modules/Setup.local
# manually disable MMAP, change pyconfig.h to "undef HAVE_MMAP"
# manually disable MMAP, change pyconfig.h to "undef WITH_PYMALLOC"
# manually patch Objects/fileobject.c, change macro GETC(f) from getc to fgetc
#   and getc_unlocked to fgetc_unlocked
# manually disable HAVE_GETC_UNLOCKED, undef
# manually disable POSIX SEMAPHORES, define "HAVE_BROKEN_POSIX_SEMAPHORES"
# manually disable POLL, define "HAVE_BROKEN_POLL"
# Note the first time compiling should use the following command to build all
# modules. But after that, when you change python source code and want to
# just recompile python, use `make -j40 python`
make -j40
extract-bc python
```

## Run
```
./python readahead.py
```
