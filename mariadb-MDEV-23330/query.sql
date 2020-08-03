CREATE TABLE t1 (a CHAR(240), b BIT(48));

INSERT INTO t1 VALUES ('a',b'0001'),('b',b'0010'),('c',b'0011'),('d',b'0100'),('e',b'0001'),('f',b'0101'),('g',b'0110'),('h',b'0111'),('i',b'1000'),('j',b'1001');

SELECT DES_DECRYPT(a, 'x'), BINARY b FROM t1 GROUP BY 1, 2 WITH ROLLUP;

 

# Cleanup

DROP TABLE t1;
