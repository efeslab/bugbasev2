CREATE DATABASE test;
USE test;
SET big_tables=1;
 
CREATE TABLE t1 (id int, name char(10), leftpar int, rightpar int);
INSERT INTO t1 VALUES
  (1, "A", 2, 3),(2, "LA", 4, 5),(4, "LLA", 6, 7),(6, "LLLA", NULL, NULL),(7, "RLLA", NULL, NULL),(5, "RLA", 8, 9),(8, "LRLA", NULL, NULL),
  (9, "RRLA", NULL, NULL),(3, "RA", 10, 11),(10, "LRA", 12, 13),(11, "RRA", 14, 15),(15, "RRRA", NULL, NULL),(16, "B", 17, 18),
  (17, "LB", NULL, NULL),(18, "RB", NULL, NULL);
 
CREATE TABLE t2 SELECT * FROM t1 ORDER BY rand();
 
WITH RECURSIVE tree_of_a AS (SELECT *, cast(id AS char(200)) AS path FROM t2 WHERE name="A" UNION ALL
  SELECT t2.*, concat(tree_of_a.path,",",t2.id) FROM t2 JOIN tree_of_a ON t2.id=tree_of_a.leftpar
    UNION ALL
  SELECT t2.*, concat(tree_of_a.path,",",t2.id) FROM t2 JOIN tree_of_a ON t2.id=tree_of_a.rightpar)
SELECT * FROM tree_of_a
ORDER BY path;
 
DROP TABLE t1,t2;