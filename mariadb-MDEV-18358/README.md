# Mariadb-MDEV-18358
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.4.1
- Cause: Null pointer dereference
- Sketch:
    * In mysql_init_select (lex=0x7fffb001e218) at /home/ry4nzzz/server/sql/sql_parse.cc:7712 
    * This line contains code ```select_lex->init_select();``` and ```select_lex = 0x0``` cause a null pointer dereference
    * ```SELECT_LEX *select_lex= lex->current_select;``` indicates lex->current_select is a nullptr. 
- Fixed Version: 10.4.6