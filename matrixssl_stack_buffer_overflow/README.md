# Info

This is CVE-2014-1569
source:
https://nvd.nist.gov/vuln/detail/CVE-2014-1569
https://www.exploit-db.com/exploits/46435

# how to compile
```
# checkout the matrixssl repo (exploit branch) OR
# apply the patch (work_with_klee.patch) on tag 4-0-1-open (5a72845)
make CC=wllvm MATRIX_DEBUG=1 CCARCH=x86_64-linux-gnu
```
note that in core/makefiles/detect-and-rules.mk, aes is disabled manually
Then you will find matrixssl/matrixssl/test/certValidate is the desired binary.

# how to reproduce the bug
```
matrixssl/matrixssl/test/certValidate stackbufferoverflow.txt
```
# Iterative process:
I faced an symbolic malloc, have to finish the first iteration very early (400K)
And by recording that (symbolic size) instruction, 24B were recorded.
