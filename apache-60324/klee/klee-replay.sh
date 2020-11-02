if [ -z $1 ]; then
  echo "${0}" '${ITER}'
  exit -1
fi
ITER=$1
source $(dirname $0)/klee-env.sh

rm -rf ${KLEE_REPLAY_OUT_DIR}
cp ${FREQ_BC} ${RUN_BC}
#perf record -g 
#gdb --args
gdb --args klee -solver-backend=z3 -call-solver=false -output-stats=false \
  -output-istats=false -oracle-KTest=oracle.ktest -use-forked-solver=false \
  -output-source=false -write-kqueries -write-paths --libc=uclibc \
  --posix-runtime -env-file=env \
  -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true \
  -replay-path=${KLEE_RECORD_OUT_DIR}/test000001.path \
  -use-independent-solver=true -oob-check=true -allocate-determ \
  -output-dir=${KLEE_REPLAY_OUT_DIR} -kinst-binding=lesscost\
  -simplify-sym-indices=true \
  -monolithic \
  ${RUN_BC} -posix-debug --unsafe -sock-handler apache-60324 \
  --symbolic-sock-handler -sym-file ../conf/mime.types \
  -sym-file ../conf/httpd.conf -sym-file /etc/passwd \
  -sym-file /etc/group --symbolic-urandom 33792 -X
#-all-external-warnings 
# -symbolic-gettimeofday \
cp ${KLEE_RECORD_OUT_DIR}/${FREQ_BC} ${KLEE_REPLAY_OUT_DIR}
