1. apply php-7.1.6.klee.patch
2. CC=wllvm ./configure --disable-all --disable-cgi --without-pcre-jit
3. make
4. you will find `php` executable at `sapi/cli/php`
5. extract-bc
