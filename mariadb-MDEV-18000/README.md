# Mariadb-MDEV-16736
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.3.3
- Root Cause: Assrtion Failed
- Sketch:
    * /home/ry4nzzz/server/sql/sql_yacc.yy:12212: int MYSQLparse(THD*): Assertion `sel->master_unit()->fake_select_lex' failed.
    * At /home/ry4nzzz/server/sql/sql_parse.cc:9988 MYSQLparse(thd) invoke parser sql_yacc.yy
- Fixed Version: Latest 10.3.7