# Mariadb-MDEV-13170
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9, 10.3.10
- Root Cause: Null Pointer Dereference
- Sketch:
    * Backtrace from gdb: 0x0000555555b8af23 in find_field_in_tables (thd=0x7fffb800d020, item=0x7fffb8077140, first_table=0x7fffb8073d80, last_table=0x0, ref=0x7fffeca5b818, report_error=IGNORE_ERRORS, check_privileges=false, register_tree_change=false) at /home/ry4nzzz/server/sql/sql_base.cc:6116.
    * At line 6116 of sql_base.cc it tries to access ```Item * subs``` by ```subs->type() == Item::SUBSELECT_ITEM``` when subs is a null pointer 0x0.
- Fixed Version: Latest 10.4.6