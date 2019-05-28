#!/bin/bash
mysql -u root -psecret << Session1
CREATE DATABASE test;
use test;
create table locker (pk int not null auto_increment, some_key varchar(10) not null, some_val varchar(25) default 'hi', primary key (pk), unique key uk_locker (some_key)); 
insert into locker values(1, 'key-one', 'some-value');
start transaction;
select * from locker where some_key='key-one' for update;
SELECT SLEEP(1);
delete from locker where some_key='key-one';
insert into locker values(1, 'key-one', 'some-value');
Session1
