mysql -uroot -psecret << PREPARE
create database test;
use test;
CREATE TABLE tu(id int(11), a int(11) DEFAULT NULL, b varchar(10) DEFAULT NULL, c varchar(10) DEFAULT NULL, PRIMARY KEY(id), UNIQUE KEY u(a,b)) ENGINE=InnoDB DEFAULT CHARSET=latin1 STATS_PERSISTENT=0;
insert into tu values(1,1,'a','a'),(2,9999,'xxxx','x'),(3,10000,'b','b'),(4,4,'c','c');
select * from tu;
PREPARE