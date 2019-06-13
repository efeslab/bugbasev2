# Mariadb-MDEV-16039
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.8, 10.3.9
- Root Cause: Null Pointer Dereference
- Sketch:
    * Backtrace from gdb: in Item_args::walk_args (this=0x7fffb8088b88, processor=&virtual table offset 776, walk_subquery=false, arg=0x0)
    at /home/ry4nzzz/server/sql/item.h:2184 and local variable```i = 0```.
    * The function ```bool walk_args(Item_processor processor, bool walk_subquery, void *arg)```, a line ```if (args[i]->walk(processor, walk_subquery, arg))``` access ```Item **args``` and ```args[0]``` is null pointer.
- Fixed Version: Latest 10.4.6