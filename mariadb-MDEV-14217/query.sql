CREATE DATABASE test;
USE test;
with recursive x as (select 1,2 union all select 1 from x) select * from x;