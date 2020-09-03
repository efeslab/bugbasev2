#!/bin/bash

workdir=`pwd`
l=`ls $workdir/png`
files=`sed 's/^/png\//g' <<< "$l" | sed -z 's/\n/ /g'`

for i in {1..10}
do
  sleep 1
  tmp1=`sudo $workdir/pngtest -m $files 2>&1 >/dev/null | awk '{print $3}'`
  cnt1=`echo "$cnt1$tmp1,"`
  echo [$i]:$tmp1

  sleep 1
  tmp2=`sudo /home/jcma/hase/bin/hase record $workdir/pngtest -m $files 2>&1 >/dev/null | awk '{print $3}'`
  cnt2=`echo "$cnt2$tmp2,"`
  echo [$i]:$tmp2

  sleep 1
  tmp3=`sudo /home/jcma/rr/obj/bin/rr record $workdir/pngtest -m $files 2>&1 >/dev/null | awk '{print $3}'`
  cnt3=`echo "$cnt3$tmp3,"`
  echo [$i]:$tmp3

done

echo "norec, $cnt1"
echo "recer, $cnt2"
echo "recrr, $cnt3"
