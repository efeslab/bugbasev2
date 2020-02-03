CVE-2004-0597
https://nvd.nist.gov/vuln/detail/CVE-2004-0597
# Description
Multiple buffer overflows in libpng 1.2.5 and earlier, as used in multiple
products, allow remote attackers to execute arbitrary code via malformed PNG
images in which (1) the png_handle_tRNS function does not properly validate the
length of transparency chunk (tRNS) data, or the (2) png_handle_sBIT or (3)
png_handle_hIST functions do not perform sufficient bounds checking.

### Build
```
# build libpng.a
mkdir libpng
tar xf xxx.tar.gz -C libpng
cd libpng
cp scripts/makefile.gcc Makefile
vim Makefile # change to "CC=wllvm"
make
# build poc using libpng.a
cd ..
wllvm libpng-2004-0597.c -Ilibpng -Llibpng -lpng -lz -lm -o poc
# trigger the bug
./poc pngtest_bad.png
extract-bc poc
```

### klee-record
```
klee -solver-backend=stp -call-solver=false -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -env-file=env -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -use-independent-solver=false -oob-check=false -allocate-determ ./poc.bc pngtest_bad.png
```

### klee-replay
```
klee -solver-backend=stp -call-solver=false -oracle-KTest=oracle.ktest -use-forked-solver=false -output-source=false -write-kqueries -write-paths --libc=uclibc --posix-runtime -env-file=env -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true -replay-path=klee-out-0/test000001.path -use-independent-solver=false -oob-check=true -allocate-determ ./poc.bc pngtest_bad.png -sym-file pngtest_bad.png ????
```
