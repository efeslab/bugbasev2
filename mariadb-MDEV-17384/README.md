# Mariadb-MDEV-17384
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.2.10, 10.2.13
- Root Cause: null pointer dereference
- Sketch:
    * In join_read_next_same (info=0x7fffb809bd60) at /home/ry4nzzz/server/sql/sql_select.cc:19506 occur a null pointer dereference.
    * ```error = 32767 table = 0x0 tab = 0x7fffb800dc90```  table is a null pointer and code ```JOIN_TAB *tab=table->reginfo.join_tab;``` results a null pointer dereference.     
- Fix version: latest 10.3, 10.4.6 (can also use docker image mariadb:latest)