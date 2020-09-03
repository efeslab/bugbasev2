#!/bin/bash

workdir=`pwd`

for i in {1..10}
do
  sleep 5
  tmp1=`sudo $workdir/fuzzcheck.nodatarec.exe test/fuzzdata1.db test/fuzzdata2.db test/fuzzdata3.db test/fuzzdata4.db test/fuzzdata5.db test/fuzzdata6.db test/fuzzdata7.db test/fuzzdata8.db | grep seconds | awk '{print $9}'`
  cnt1=`echo "$cnt1$tmp1,"`
  echo [$i]:$tmp1

  sleep 5
  tmp2=`sudo /home/jcma/hase/bin/hase record $workdir/fuzzcheck.datarec.exe test/fuzzdata1.db test/fuzzdata2.db test/fuzzdata3.db test/fuzzdata4.db test/fuzzdata5.db test/fuzzdata6.db test/fuzzdata7.db test/fuzzdata8.db | grep seconds | awk '{print $9}'`
  cnt2=`echo "$cnt2$tmp2,"`
  echo [$i]:$tmp2

  #sleep 5
  #tmp3=`sudo /home/jcma/rr/obj/bin/rr record $workdir/fuzzcheck.nodatarec.exe test/fuzzdata1.db test/fuzzdata2.db test/fuzzdata3.db test/fuzzdata4.db test/fuzzdata5.db test/fuzzdata6.db test/fuzzdata7.db test/fuzzdata8.db | grep seconds | awk '{print $9}'`
  #cnt3=`echo "$cnt3$tmp3,"`
  #echo [$i]:$tmp3
done

echo "norec: $cnt1"
echo "recer: $cnt2"
echo "recrr: $cnt3"
