# Mariadb-MDEV-16736
- Behavior: Server Crash (Segmentation fault / [ERROR] mysqld got signal 11;)
- Crash version: mariadb 10.2.13 10.2.14
- Root Cause: Null pointer dereference
- Sketch:
    * In ```set_field_to_null_with_conversions (field=0x0, no_conversions=true)``` at /home/ry4nzzz/server/sql/field_conv.cc:204, the code ```if (field->table->null_catch_flags & CHECK_ROW_FOR_NULLS_TO_REJECT)``` try to access member of field and while filed is a null pointer in this case
- Fixed Version: Latest 10.4.6