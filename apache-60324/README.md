### download source code
get 'http://archive.apache.org/dist/httpd/httpd-2.4.6.tar.gz'
get 'http://mirror.cc.columbia.edu/pub/software/apache//apr/apr-1.7.0.tar.gz'
get 'http://mirror.cc.columbia.edu/pub/software/apache//apr/apr-util-1.6.1.tar.gz'
get 'https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz'
extract all of them in the same dir, you will get
  `${srcdir}/{httpd-2.4.6,apr-1.7.0,apr-util-1.6.1,pcre-8.43}`
The following steps will configure each component and install to
  `${srcdir}/install`

### configure `apr`
TODO: warn: this calls getrandom, need model in POSIX and this is better to
handle than /dev/random since the POSIX arguments tells you the size of the
buffer.
**Need patch**:
```
cd ${srcdir}/apr-1.7.0
patch -p1 < ../patches/apr-1.7.0.patch
```
patch NOTE:
1. You need to disable mmap based allocator
2. Also need to hack `configure` to
  - enforce 'hasprocpthreadser="0"' when test `".$ac_rc" = .yes`
  - enforce `hassysvser="0"`, same as above
  - enforce `apr_cv_mutex_robust_shared=no` before test it = "yes"
  - disable SYSV sem check
  - disable shared memory support
    - you cannot disable all of shmgetanon mmapzero mmapanon, required one implementation
    - instead, I hack to force `sharedmem=0`
  - disable `epoll`, `POLL`, `POLL_CREATE` to force use `SELECT`
  - hack poll/unix/select.c to redefine `FD_ZERO` without inline asm

NOTE:
1. Need to use `realpath xxx` as prefix, since relative dir misled httpd to
   include same header file twice.
```
CC=wllvm ./configure --prefix=`realpath $PWD/../install` --disable-posix-shm --disable-allocator-uses-mmap --disable-shared --disable-malloc-debug
#NOTE: `make -j` did not work here
make install
```

### configure `apr-utils`
TODO: this may call expat (an XML parsing library)

NOTE:
1. Need to use `realpath xxx`, same reason as above.
```
CC=wllvm ./configure --prefix=`realpath $PWD/../install` --with-apr=$PWD/../install --without-crypto --without-openssl --without-nss --without-commoncrypto --without-lber --without-ldap --with-dbm=sdbm --without-gdbm --without-ndbm --without-berkeley-db --without-pgsql --without-mysql --without-sqlite3 --without-sqlite2 --without-oracle --without-odbc --without-iconv
#NOTE: `make -j` did not work here
make install
```

### configure pcre:
CC=wllvm CXX=wllvm++ ./configure --disable-shared --disable-cpp --disable-pcregrep-jit --prefix=$PWD/../install
```
config log:

pcre-8.43 configuration summary:

    Install prefix .................. : /usr/local
    C preprocessor .................. : wllvm -E
    C compiler ...................... : wllvm
    C++ preprocessor ................ : wllvm++ -E
    C++ compiler .................... : wllvm++
    Linker .......................... : /usr/bin/ld -m elf_x86_64
    C preprocessor flags ............ :
    C compiler flags ................ : -g -O2 -fvisibility=hidden
    C++ compiler flags .............. : -O2 -fvisibility=hidden -fvisibility-inlines-hidden
    Linker flags .................... :
    Extra libraries ................. :

    Build 8 bit pcre library ........ : yes
    Build 16 bit pcre library ....... : no
    Build 32 bit pcre library ....... : no
    Build C++ library ............... : no
    Enable JIT compiling support .... : no
    Enable UTF-8/16/32 support ...... : no
    Unicode properties .............. : no
    Newline char/sequence ........... : lf
    \R matches only ANYCRLF ......... : no
    EBCDIC coding ................... : no
    EBCDIC code for NL .............. : n/a
    Rebuild char tables ............. : no
    Use stack recursion ............. : yes
    POSIX mem threshold ............. : 10
    Internal link size .............. : 2
    Nested parentheses limit ........ : 250
    Match limit ..................... : 10000000
    Match limit recursion ........... : MATCH_LIMIT
    Build shared libs ............... : no
    Build static libs ............... : yes
    Use JIT in pcregrep ............. : no
    Buffer size for pcregrep ........ : 20480
    Link pcregrep with libz ......... : no
    Link pcregrep with libbz2 ....... : no
    Link pcretest with libedit ...... : no
    Link pcretest with libreadline .. : no
    Valgrind support ................ : no
    Code coverage ................... : no
```
make -j24 install


### configure httpd:
**Need patch:**
```
cd ${srcdir}/httpd-2.4.6
patch -p1 < ../patches/httpd-2.4.6.patch
```
patches NOTE:
1. hack `configure` to:
    - disable thread-safe pollsets
```
CC=wllvm ./configure --disable-shared --disable-ssl --enable-mods-static=all --prefix=$PWD/../install --disable-cgi --disable-cgid --with-pcre=$PWD/../install --with-apr=$PWD/../install --with-apr-util=$PWD/../install --disable-auth-digest
make -j24 install
```


### Configuration httpd
So far, you should have a runnable httpd elf binary using configurations under
`${srcdir}/install/conf`
Now you need to tweak httpd configuration at `${srcdir}/install/conf/httpd.conf`
1. Use unprivileged port: change to `Listen 127.0.0.1:40880`
2. Config a aliasmatch: add `AliasMatch /rest* /apache/webd` under
   `alias_module`, near `ScriptAlias`

An example httpd.conf can be found in `klee/httpd.example.conf`

### Confirm bug using elf binary
```
cd ${srcdir}/install/bin
# httpd should hang here and wait for requests
./httpd -X
# run this in another process
curl -vvv http://127.0.0.1:40880/rest/running/config/port/port-name/user_portnumber_12
```
The httpd should abort.

### Record httpd failure in klee
use the provided klee scripts under dir `klee`
```
cd ${srcdir}/install/bin
ln -s ../../klee/* .
bash klee-record.sh 0
```
