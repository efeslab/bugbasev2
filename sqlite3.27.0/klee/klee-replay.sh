set -e
if [ -z $1 ]; then
  echo "${0}" '${ITER}'
  exit -1
fi
ITER=$1
source $(dirname $0)/klee-env.sh

rm -rf ${KLEE_REPLAY_OUT_DIR}
cp ${PREPASS_BC} ${RUN_BC}
# disable oob during the first few iterations
# enable oob in the last iteration (replaying full trace)
gdb --args klee -solver-backend=stp -call-solver=false -output-stats=false \
  -output-istats=false -use-forked-solver=false \
  -output-source=false -write-kqueries -write-paths --libc=uclibc \
  --posix-runtime -env-file=env -oracle-KTest=oracle.ktest \
  -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true \
  -replay-path=${KLEE_RECORD_OUT_DIR}/test000001.path \
  -use-independent-solver=true -oob-check=true -allocate-determ \
  -output-dir=${KLEE_REPLAY_OUT_DIR} -kinst-binding=callstacktopfirst \
  ${RUN_BC} -init test.sqlite -sym-file test.sqlite
cp ${KLEE_RECORD_OUT_DIR}/${FREQ_BC} ${KLEE_REPLAY_OUT_DIR}
################################################################################
# Remember to enable oob-check=true in the last replay
################################################################################
