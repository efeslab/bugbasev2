#!/bin/bash
exec 30> >(mysql -uroot -psecret)
echo "CREATE DATABASE test;" >&30
echo "use test;" >&30
echo "create table locker (pk int not null auto_increment, some_key varchar(10) not null, some_val varchar(25) default 'hi', primary key (pk), unique key uk_locker (some_key));" >&30
echo "insert into locker values(1, 'key-one', 'some-value');" >&30 
echo "start transaction;" >&30
echo "select * from locker where some_key='key-one' for update;" >&30 
exec 40> >(mysql -uroot -psecret) 
echo "use test;" >&40 
echo "start transaction;" >&40 
echo "select * from locker where some_key='key-one' for update;" >&40 
echo "delete from locker where some_key='key-one';" >&30 
echo "insert into locker values(1, 'key-one', 'some-value');" >&30
30>&- 
40>&-
