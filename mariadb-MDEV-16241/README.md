# Mariadb-MDEV-16241
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9
- Cause: Assertion failed
- Sketch:
    * Output from gdb: /home/ry4nzzz/server/sql/handler.h:3068: ```int handler::ha_rnd_end(): Assertion `inited==RND'``` failed.
    * From handler.h:2891  ```enum init_stat { NONE=0, INDEX, RND };```. In this case, the enum type init_stat if not RND.
- Fixed Version: 10.4.6