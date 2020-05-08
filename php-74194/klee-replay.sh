if [ -z $1 ]; then
  echo "${0}" '${ITER}'
  exit -1
fi
ITER=$1
source $(dirname $0)/klee-env.sh

rm -rf ${KLEE_REPLAY_OUT_DIR}
cp ${PREPASS_BC} ${RUN_BC}
klee -solver-backend=stp -call-solver=false -output-stats=false \
  -output-istats=false -oracle-KTest=oracle.ktest -use-forked-solver=false \
  -output-source=false -write-kqueries -write-paths --libc=uclibc \
  --posix-runtime -env-file=php_env \
  -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true \
  -replay-path=${KLEE_RECORD_OUT_DIR}/test000001.path \
  -use-independent-solver=true -oob-check=true -allocate-determ \
  -all-external-warnings -output-dir=${KLEE_REPLAY_OUT_DIR} -kinst-binding=firstoccur\
  ${RUN_BC} poc.php data -posix-debug -sym-file poc.php -sym-file data
cp ${KLEE_RECORD_OUT_DIR}/${FREQ_BC} ${KLEE_REPLAY_OUT_DIR}
