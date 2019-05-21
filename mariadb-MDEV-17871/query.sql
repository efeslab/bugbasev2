CREATE DATABASE test;
USE test;
create table t1 ( i1 int, i2 int);
insert into t1 values (1,1),(2,2);
    
explain with recursive cte as
  ( select * from t1 union  select s1.* from t1 as s1, cte  where s1.i1 = cte.i2 ) select * from t1;
  