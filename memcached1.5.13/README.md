### build libevent
apply two patches:

1. "libevent_select_only.patch" to enforce libevent only uses select interface,
   which is supported by the POSIX runtime.
2. "libevent_remove_randomness.patch" to removing unmodeled randomness from
   "gettimeofday".

CC=wllvm ./configure --disable-shared -enable-static --disable-thread-support --disable-malloc-replacement --prefix=$PWD/install

### build memcached

CC=wllvm ./configure --disable-docs --with-libevent=$PWD/../libevent-2.1.11-stable/install --prefix=$PWD/install
