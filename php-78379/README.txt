[bug 78379](https://bugs.php.net/bug.php?id=78379)
- The bug is verified by using AddressSanitizer and USE_ZEND_ALLOC=0 as php runtime configuration. However, there is no simple test case for us to reproduce the bug(cause `php` crash). Considering the potential value of this bug since it seems to be hard to fix, we still put it in our bugbase.
- plausible ways to reproduce: https://phabricator.wikimedia.org/T228346
