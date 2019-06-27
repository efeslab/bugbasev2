# Mariadb-MDEV-16801
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.8
- Root Cause: Null Pointer Dereference
- Sketch:
    * In ``` st_key::actual_rec_per_key (this=0x0, i=0) at /home/ry4nzzz/server/sql/table.cc:8448```, object is a null pointer.
    * In ```st_join_table::choose_best_splitting (this=0x7fffb00a1228, record_count=1, remaining_tables=2) at /home/ry4nzzz/server/sql/opt_split.cc:919```, variable ```key_info = 0x0``` and ``` double rec_per_key = key_info->actual_rec_per_key(keyuse_ext->keypart);``` 
- Fixed Version: Latest 10.3.7