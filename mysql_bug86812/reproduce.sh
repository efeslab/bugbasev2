mysql -uroot -psecret 
mysql -uroot -psecret --execute="CREATE DATABASE test"
mysql -uroot -psecret -e "USING DATABASE test"
mysql -uroot -psecret -e "create table locker (pk int not null auto_increment, some_key varchar(10) not null, some_val varchar(25) default 'hi', primary key (pk), unique key uk_locker (some_key));"
mysql -uroot -psecret 