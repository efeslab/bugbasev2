#!/bin/bash

workdir=`pwd`

for i in {1..10}
do
  tmp=`sudo $workdir/fuzzcheck test/fuzzdata1.db test/fuzzdata2.db test/fuzzdata3.db test/fuzzdata4.db test/fuzzdata5.db test/fuzzdata6.db test/fuzzdata7.db test/fuzzdata8.db | grep seconds | awk '{print $9}'`
  cnt=`echo "$cnt$tmp,"`
  #echo [$i]:$tmp
done

echo $cnt
