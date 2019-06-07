# Mariadb-MDEV-17366
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9
- Description: using two window function cause crash
- Sketch:
    - in Item_field::Item_field at /10.3/sql/item.cc:3114
        occur a null pointer dereference
- Fix version: latest 10.3 (can also use docker image mariadb:latest)