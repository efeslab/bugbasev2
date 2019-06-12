# Mariadb-MDEV-17211
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.9, 10.3.10
- Root Cause: Null Pointer Dereference
- Sketch:
    * In Index_statistics::get_avg_frequency (this=0x0, i=0) at /home/ry4nzzz/server/sql/sql_statistics.h:416, the program tried to access member function of class Index_statistics, but the pointer to class itself (this) is nullptr
    * Backtrace from gdb: In Index_statistics::get_avg_frequency (**this=0x0**, i=0) at /home/ry4nzzz/server/sql/sql_statistics.h:416 return (double) avg_frequency[i] / Scale_factor_avg_frequency;
- Fixed Version: 10.4.6