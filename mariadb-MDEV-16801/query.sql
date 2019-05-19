CREATE DATABASE test;
USE test;
CREATE TABLE t1 (
  i1 int, i2 int, i3 int, i4 int, i5 int, i6 int, i7 int, i8 int,
  c1 int, c2 int, p1 int,
  KEY (i1), KEY (i2), KEY (c2), KEY (i7), KEY (i4), KEY (i8), KEY (i6), KEY (p1) 
) ENGINE=InnoDB ;
 
CREATE TABLE t2 (l1 int, a1 int, p4 int, d1 int, c2 int) ENGINE=InnoDB;
CREATE TABLE t3 (l1 int, p2 int, p3 int) ENGINE=InnoDB ;
 
UPDATE  t1,
  (SELECT t1.p1, t1.c1, tmp1.c2 
    FROM  t1,
      (SELECT ck.c2,CONCAT(t3.p2,'%') AS p4
          FROM t2 ck 
      JOIN t3 ON t3.p3 = LEFT(ck.p4, length(ck.p4)-1)
      ) tmp1
   GROUP BY p1,tmp1.c2 
  ) tmp2
SET t1.c1 = tmp2.c2
WHERE t1.p1 = tmp2.p1 ;