CREATE DATABASE test;
USE test;
drop table if exists dummy;
 
create table dummy (
   field1 int
 ) engine=innodb default charset=utf8;
 
insert into dummy values (1);
 
select round((select 1 from dummy limit 1))
from dummy
group by round((select 1 from dummy limit 1));