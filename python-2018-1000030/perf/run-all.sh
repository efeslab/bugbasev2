#!/bin/bash

for i in {1..10}
do
  sleep 1
  tmp1=`sudo ~/bugbasev2/python-31530/cpython/build/python.gefei.exe performance/run.py -n 2 2>&1 >/dev/null | tail -n 1 | awk '{print $3}'`
  cnt1=`echo "$cnt1$tmp1,"`
  echo [$i]:$tmp1

  sleep 1
  tmp2=`sudo /home/jcma/hase/bin/hase record ~/bugbasev2/python-31530/cpython/build/python.gefei.datarec.1.exe performance/run.py -n 2 2>&1 >/dev/null | tail -n 1 | awk '{print $3}'`
  cnt2=`echo "$cnt2$tmp2,"`
  echo [$i]:$tmp2

  sleep 1
  tmp3=`sudo /home/jcma/rr/obj/bin/rr record ~/bugbasev2/python-31530/cpython/build/python.gefei.datarec.1.exe performance/run.py -n 2 2>&1 >/dev/null | tail -n 1 | awk '{print $3}'`
  cnt3=`echo "$cnt3$tmp3,"`
  echo [$i]:$tmp3
done

echo "norec, $cnt1"
echo "recer, $cnt2"
echo "recrr, $cnt3"
