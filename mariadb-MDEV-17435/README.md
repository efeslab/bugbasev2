# Mariadb-MDEV-17435
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Error message from backtrace: Some pointers may be invalid and cause the dump to abort.
- Root Cause: Invalid pointer dereference.
- Sketch: Backtrace from gdb:
     * Thread 33 "mysqld" received signal SIGSEGV, Segmentation fault.[Switching to Thread 0x7fffeca5e700 (LWP 65163)] 0x0000555555d1a207 in st_select_lex::get_free_table_map (this=0x7fffb80aa3f0, map=0x7fffeca5a310, tablenr=0x7fffeca5a30c) at /home/ry4nzzz/server/sql/sql_lex.cc:4271      if (tl->table->map > *map)
     * list iterator ti at /home/ry4nzzz/server/sql/sql_lex.cc:4268 reach list.end() and visiting member of list.end() cause invalid pointer
- Fix version: still crash on server version 10.4.6 (will update if any there is any changes)