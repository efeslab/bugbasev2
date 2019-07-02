#!/bin/bash
exec 30> >(mysql)
echo "CREATE DATABASE test;" >&30
echo "use test;" >&30
echo "create table t1(id INT,PRIMARY KEY(id))ENGINE=InnoDB;" >&30
echo "INSERT INTO t1 VALUES(1), (2), (3);" >&30
echo "BEGIN;SELECT * FROM t1 WHERE id = 1 FOR UPDATE;" >&30
exec 40> >(mysql)
echo "use test;" >&40
echo "BEGIN;SELECT * FROM t1 WHERE id = 2 FOR UPDATE;" >&40
echo "SELECT * FROM t1 WHERE id = 1 FOR UPDATE;" >&40
echo "SELECT * FROM t1 WHERE id = 2 FOR UPDATE;" >&30 2>&1