CREATE DATABASE test;
USE test;
create table t1 ( a1 varchar(25));
create table t2 ( a2 varchar(25)) ;
insert into t1 select 'xxx' from dual where 'xxx' in (select a2 from t2);