# Mariadb-MDEV-18896
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.2.13 10.2.22
- Root Cause: null pointer dereference
- Sketch:
    * In ```convert_subq_to_sj (parent_join=0x7fffb801df28, subq_pred=0x7fffb801dbf8) at /home/ry4nzzz/server/sql/opt_subselect.cc:1646```.
    * ```for (tl= (TABLE_LIST*)(parent_lex->table_list.first); tl->next_local; tl= tl->next_local)``` try to access member of pointer tl, and from gdb, ```tl = 0x0```       
- Fix version: latest 10.3, 10.4.6 (can also use docker image mariadb:latest)