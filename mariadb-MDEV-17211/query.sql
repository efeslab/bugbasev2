CREATE DATABASE test;
USE test;
CREATE TABLE t1 ( id1 int, i1 int, id2 int, PRIMARY KEY (id1), KEY (i1), KEY (id2)) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1,1,1);
 
CREATE TABLE t2 (id2 int, i2 int) ENGINE=InnoDB;
INSERT INTO t2  VALUES (1, 1);
 
CREATE TABLE t3 (id3 int, i3 int, PRIMARY KEY (id3)) ENGINE=InnoDB;
INSERT INTO t3 VALUES (1,1);
 
SELECT id3 FROM 
(SELECT t3.id3, t2.i2, t1.id2  FROM t3 
   JOIN t1 ON t3.i3=t1.id1
   JOIN t2 ON t2.id2=t1.id2 
   GROUP BY t3.id3, t1.id2) tbl
 JOIN t2 ON t2.id2=tbl.id2;