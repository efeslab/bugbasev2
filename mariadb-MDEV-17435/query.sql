CREATE DATABASE test;
USE test;
CREATE TABLE t1 (pk int);
CREATE TABLE t2 (c1 int, pk int);
create view v1 as select * from t1;
create view v2 as select * from t2;
create procedure p1 ()
UPDATE (v1 RIGHT JOIN (t1 JOIN v2 ON (t2.c1 = t1.c1)) ON (t2.c1 = t1.c1)) SET t1.pk = 94;
CALL p1();
CALL p1();