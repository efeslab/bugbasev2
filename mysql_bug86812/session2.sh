#!/bin/bash
mysql -u root -psecret << Session2
use test;
start transaction; 
select * from locker where some_key='key-one' for update;
SELECT SLEEP(5);
Session2