# Mariadb-MDEV-19132
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.13
- Root Cause: null pointer dereference
- Sketch:
    * In opt_split.cc:1152, JOIN::fix_all_splittings_in_plan()       
- Fix version: latest 10.3, 10.4.6 (can also use docker image mariadb:latest)