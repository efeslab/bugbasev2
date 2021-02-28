#!/bin/bash
if [ -z $1 ]; then
  iter=1
else
  iter=$1
fi
echo "#############################"
echo "##    Build Everything     ##"
echo "#############################"
make all-bc
while true; do
  echo "#############################"
  echo "## Start iteration ${iter}"
  echo "#############################"
  make record.${iter}.klee-out
  ret=$?
  if [ $ret -eq 0 ]; then
    make replay.${iter}.klee-out
    iter=$(($iter+1))
    continue
  elif [ $ret -eq 2 ]; then
    lastiter=$(($iter-1))
    if [ -f replay.${lastiter}.klee-out/fully_replayed ]; then
      echo "#############################"
      echo "## Fully Replayed: abort   ##"
      echo "#############################"
      make verify;
      break;
    else
      echo "Unknown recording failure"
      exit $ret
    fi
  else
    echo "Unhandled make error"
    exit $ret
  fi
  case $ret in
    2) make verify; break ;;
    *) echo "Error"; exit $ret ;;
  esac
done
echo "ER Finished"
make report
