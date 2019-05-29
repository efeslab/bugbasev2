CREATE DATABASE test;
USE test;
create table testcrash (id int not null primary key, first_name varchar(255), last_name varchar(255));
 
select testcrash.first_name, testcrash.last_name,
ifnull((SELECT count(id) from testcrash where id = 0), 0) as data
 from testcrash 
group by id
order by IFNULL((SELECT count(id) from testcrash where id = 0), 0)
LIMIT 0,25;