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
make
# build poc using libpng.a
cd ..
gcc libpng-2004-0597.c -Ilibpng -Llibpng -lpng -lz -lm
# trigger the bug
./a.out pngtest_bad.png
```
