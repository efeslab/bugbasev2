# Mariadb-MDEV-17366
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9
- Description: using two window function cause crash
- Root Cause: null pointer dereference
- Sketch:
    * In Item_field::Item_field at /10.3/sql/item.cc:3107
        occur a null pointer dereference.
    * Item_field::Item_field (this=0x7fffb8029db0, thd=0x7fffb801a150, f=0x0) at /home/ry4nzzz/server/sql/item.cc:3107 :Item_ident(thd, 0, NullS, *f->table_name, &f->field_name), Filed pointer f is a null pointer (0x0)       
- Fix version: latest 10.3, 10.4.6 (can also use docker image mariadb:latest)