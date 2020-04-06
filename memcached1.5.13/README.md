# Info

This is CVE-2019-11596
Source: https://nvd.nist.gov/vuln/detail/CVE-2019-11596

Patched commit: d35334f368817a77a6bd1f33c6a5676b2c402c02

### build libevent
apply two patches:

1. "libevent_select_only.patch" to enforce libevent only uses select interface,
   which is supported by the POSIX runtime.
2. "libevent_remove_randomness.patch" to removing unmodeled randomness from
   "gettimeofday".

CC=wllvm ./configure --disable-shared -enable-static --disable-thread-support --disable-malloc-replacement --prefix=$PWD/install

### build memcached

CC=wllvm ./configure --disable-docs --with-libevent=$PWD/../libevent-2.1.11-stable/install --prefix=$PWD/install
