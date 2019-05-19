#!/bin/bash
exec 3> >(mysql -uroot -psecret)
echo "USE test" >&3
echo "SET SESSION tx_isolation = 'READ-COMMITTED';" >&3
echo "BEGIN;" >&3
echo "UPDATE t1 SET updated_at = NOW() WHERE id = 1;" >&3
exec 4> >(mysql -uroot -psecret)
echo "SET SESSION tx_isolation = 'READ-COMMITTED';" >&4
echo "BEGIN;" >&4
echo "USE test" >&4
echo "UPDATE t1_hist SET updated_at = NOW() WHERE t1_id = 1;" >&4
echo "INSERT INTO t1_trig VALUES (DEFAULT);" >&4
echo "UPDATE t1_hist SET updated_at = NOW() WHERE t1_id = 1;" >&3
echo "deadlock should happen here" 1>&2
./dump
3>&-
4>&-
