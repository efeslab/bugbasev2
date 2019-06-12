# Mariadb-MDEV-17222
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9, 10.3.10
- Root Cause: Assertion failed (The same as Mariadb bug 17668)
- Sketch:
    * Field_iterator_table::create_item (this=0x7fffeca5bc60, thd=0x7fffb801a150) at /home/ry4nzzz/server/sql/table.cc:5877 
    * This line contains code ```DBUG_ASSERT(strlen(item->name.str) == item->name.length);``` and ```strlen(item->name.str) != item->name.length``` cause assertion failed 
- Fixed Version: 10.4.6