#!/bin/bash

workdir=`pwd`

for i in {1..10}
do
  rm -rf sqlite3.tar.bz2
  sleep 1
  tmp1=`sudo $workdir/pbzip2.nodatarec.exe -b1 -k -f -p2 sqlite3.tar 2>&1 >/dev/null | grep seconds | awk '{print $3}'`
  cnt1=`echo "$cnt1$tmp1,"`
  echo [$i]:$tmp1

  rm -rf sqlite3.tar.bz2
  sleep 1
  tmp2=`sudo /home/jcma/hase/bin/hase record $workdir/pbzip2.datarec.exe -b1 -k -f -p2 sqlite3.tar 2>&1 >/dev/null | grep seconds | awk '{print $3}'`
  cnt2=`echo "$cnt2$tmp2,"`
  echo [$i]:$tmp2

  rm -rf sqlite3.tar.bz2
  sleep 1
  tmp3=`sudo /home/jcma/rr/obj/bin/rr record $workdir/pbzip2.nodatarec.exe -b1 -k -f -p2 sqlite3.tar 2>&1 >/dev/null | grep seconds | awk '{print $3}'`
  cnt3=`echo "$cnt3$tmp3,"`
  echo [$i]:$tmp3
done

echo "norec, $cnt1"
echo "recer, $cnt2"
echo "recrr, $cnt3"
