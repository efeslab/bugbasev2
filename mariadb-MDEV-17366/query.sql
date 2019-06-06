CREATE DATABASE test;
USE test;
CREATE TABLE t(a int)engine=innodb;
INSERT INTO t VALUES(1),(2),(3);
 
WITH cte AS
  (SELECT NTILE(124) OVER()
   FROM t
   WHERE @g NOT LIKE 1
   GROUP BY @f
   ORDER BY a)
SELECT * FROM cte;