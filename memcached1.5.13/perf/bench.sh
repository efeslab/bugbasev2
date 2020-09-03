#!/bin/bash

workdir=`pwd`

for i in {1..20}
do
  tmp=`memtier_benchmark -t 1 -S /tmp/memcached.sock -P memcache_binary 2>&1 | grep Totals | awk '{print $2}'`
  cnt=`echo "$cnt$tmp,"`
  echo [$i]:$tmp
done

echo $cnt
