# Mariadb-MDEV-16931
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.7，10.3.9
- Root Cause: Access char* out of bond (Null Pointer Dereference)
- Sketch:
    * In ```my_strcasecmp_utf8 (cs=0x5555573ab440 <my_charset_utf8_general_ci>, s=0x7fffb8028ba8 "2", t=0x0)``` at /home/ry4nzzz/server/strings/ctype-utf8.c:5304, the code ```while (s[0] && t[0])``` try to access char* array t and t is null pointer in this case
- Fixed Version: Latest 10.4.6