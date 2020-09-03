#!/bin/bash

workdir=`pwd`

for i in {1..10}
do
  sleep 1
  tmp1=`USE_ZEND_ALLOC=0 sudo $workdir/php.nodatarec.exe $workdir/bench.php | grep Total | awk '{print $4}'`
  cnt1=`echo "$cnt1$tmp1,"`
  echo [$i]:$tmp1

  sleep 1
  tmp2=`USE_ZEND_ALLOC=0 sudo /home/jcma/hase/bin/hase record $workdir/php.datarec.exe $workdir/bench.php | grep Total | awk '{print $4}'`
  cnt2=`echo "$cnt2$tmp2,"`
  echo [$i]:$tmp2

  sleep 1
  tmp3=`USE_ZEND_ALLOC=0 sudo /home/jcma/rr/obj/bin/rr record ./php.nodatarec.exe bench.php | grep Total | awk '{print $4}'`
  cnt3=`echo "$cnt3$tmp3,"`
  echo [$i]:$tmp3
done

echo $cnt1
echo $cnt2
echo $cnt3
