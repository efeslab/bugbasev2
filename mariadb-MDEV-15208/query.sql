CREATE DATABASE test;
USE test;
CREATE TABLE t (a INT);
INSERT INTO t VALUES (1),(1),(1),(1),(1),(2),(2),(2),(2),(2),(2);
SELECT 1 UNION SELECT a FROM t ORDER BY (row_number() over ());