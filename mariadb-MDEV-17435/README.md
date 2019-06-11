# Mariadb-MDEV-17435
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Error message from backtrace: Some pointers may be invalid and cause the dump to abort. nptl/pthread_create.c:463(start_thread)[0x7fb35b87b6db]
x86_64/clone.S:97(clone)[0x7fb35aa6188f]
- Fix version: still crash on server version 10.4.6 (will update if any there is any changes)