#!/bin/bash
set -e
help() {
  echo "Expected env: HASE_PY"
  echo "Optional env: INTERMEDIATE_SUFFIX"
  echo "usage: ${0} freq.*.bc replay.*.klee-out output/datarec.*.cfg"
  echo "Exit status: error (-1), normal (0), fully replayed (1)"
}
convert_kquery() {
  BITCODE=$1
  KQUERY=$2
  kleaver -draw -all -bitcode ${BITCODE} ${KQUERY}
}
simple_concretize() {
  KQUERY=$1
  convert_kquery ${FREQ_BC} ${KQUERY}
  JSON=${KQUERY}.simplify.json
  NEWDATAREC=${KQUERY}.datarec.cfg
  ${HASE_PY} --noptwrite --datarec-out ${NEWDATAREC} ${JSON} \
    > ${KQUERY}${INTERMEDIATE_SUFFIX}.analysis
  cp ${NEWDATAREC} ${OUTPUT_CFG}
}
analyze_recordUN() {
  KQUERY=$1
  convert_kquery ${FREQ_BC} ${KQUERY}
  JSON=${KQUERY}.simplify.json
  GETUN=${KQUERY}${INTERMEDIATE_SUFFIX}.getUN
  ${HASE_PY} --getUN ${JSON} > ${GETUN}
  TARGET_ARR=$(grep 'target_array' < ${GETUN} | cut -d':' -f2)
  NEWDATAREC=${KQUERY}.datarec.cfg
  ${HASE_PY} --recordUN="${TARGET_ARR}" --noptwrite \
	--datarec-out ${NEWDATAREC} ${JSON} \
	> ${KQUERY}${INTERMEDIATE_SUFFIX}.analysis
  cp ${NEWDATAREC} ${OUTPUT_CFG}
}
if [ $# -ne 3 ]; then
  help
  echo "[$#]"
  exit -1
fi
if [ ! -f ${HASE_PY} ]; then
  echo "Invalid HASE_PY: ${HASE_PY}"
  exit -1
fi
FREQ_BC=$1
if [ ! -f ${FREQ_BC} ]; then
  echo "Invalid FREQ_BC: ${FREQ_BC}"
  exit -1
fi
REPLAY_PATH=$2
if [ ! -d ${REPLAY_PATH} ]; then
  echo "Path ${REPLAY_PATH} is invalid"
  exit -1
fi
OUTPUT_CFG=$3

TESTCASE=test000001
EARLY_PATH=${REPLAY_PATH}/${TESTCASE}.early
WARNING_PATH=${REPLAY_PATH}/warnings.txt
TIMEOUT_PATH=${REPLAY_PATH}/${TESTCASE}.timeout.err
ABORT_ERR_PATH=${REPLAY_PATH}/${TESTCASE}.abort.err
AMBIGUOUS_PATH=${REPLAY_PATH}/AmbiguousAddress.kquery
SYM_POSIX_PATH=${REPLAY_PATH}/symbolicPOSIX.kquery
SYM_MALLOC_PATH=${REPLAY_PATH}/symbolicMalloc.kquery
if [ -f ${TIMEOUT_PATH} ]; then
  echo "Solver timed out"
  KQUERY=${REPLAY_PATH}/${TESTCASE}.kquery
  analyze_recordUN ${KQUERY}
elif [ -f ${EARLY_PATH} ]; then
  echo "Terminate Early"
  echo "##########################################"
  echo "####(Should only happen during debugging)#"
  echo "##########################################"
  KQUERY=${REPLAY_PATH}/${TESTCASE}.kquery
  analyze_recordUN ${KQUERY}
elif [ -f ${ABORT_ERR_PATH} ]; then
  if [ -f ${AMBIGUOUS_PATH} ]; then
	echo "Ambiguous Address"
	simple_concretize ${AMBIGUOUS_PATH}
  elif [ -f ${SYM_POSIX_PATH} ]; then
	echo "Symbolic POSIX"
	simple_concretize ${SYM_POSIX_PATH}
  elif [ -f ${SYM_MALLOC_PATH} ]; then
	echo "Symbolic malloc"
	simple_concretize ${SYM_MALLOC_PATH}
  fi
else
  echo "Fully replayed"
  touch ${REPLAY_PATH}/fully_replayed
  exit 1
fi
exit 0
