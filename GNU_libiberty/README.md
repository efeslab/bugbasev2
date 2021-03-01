### BUG
[CVE-2018-6323](https://www.cvedetails.com/cve/CVE-2018-6323/)
[bugzilla](https://sourceware.org/bugzilla/show_bug.cgi?id=22746)
The test case attached in
[exploit-db](https://www.exploit-db.com/exploits/44035) does not trigger out of
bound access in klee. However, the attachment in the origin bugzilla report
triggers bug in klee.

### build
[binutils-2.26](https://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.gz)
Note that compile in 32bit mode (-m32) will trigger failure in elf.
Compile in 64bit mode will trigger falilure in klee, not in elf. (Did not
confirm whether they are from the same root cause).
```
CC=wllvm CFLAGS='-fbracket-depth=512 -g -O2 -fno-omit-frame-pointer -m32' \
./configure --enable-gold=no --enable-ld=no --disable-libquadmath \
--disable-libstdcxx --enable-bootstrap=no --enable-lto=no \
--enable-werror=no --enable-host-shared=no
```
the binary you need is binutils-2.26/binutils/objdump

### reproduce the bug
```
binutils-2.26/binutils/objdump -x c2
```
Note: nothing may happen here.

### klee-record
```
extract-bc binutils-2.26/binutils/objdump
cp binutils-2.26/binutils/objdump.bc ./
klee -solver-backend=stp -call-solver=false -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -env-file=env -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -use-independent-solver=false -oob-check=false -allocate-determ -all-external-warnings binutils-2.26/binutils/objdump.bc -x c2
```

## For new assertions during replay (vassert): apply `new_assertions.patch`
