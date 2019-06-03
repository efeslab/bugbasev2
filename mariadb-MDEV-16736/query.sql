CREATE DATABASE test;
USE test;
CREATE TABLE t1 (id int NOT NULL);
INSERT INTO t1 VALUES (1), (2), (3), (4);
 
SELECT 1 FROM t1 
ORDER BY lag(id) OVER (order by id) -1;