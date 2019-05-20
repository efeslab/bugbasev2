CREATE DATABASE test;
USE test;
CREATE TABLE t1 (i INT, a char);
INSERT INTO t1 VALUES (1, 'a'),(2, 'b');
create view v1 as select * from t1;
PREPARE stmt FROM "SELECT i, row_number() over (partition by i order by i) FROM v1";
execute stmt;