#################################################################
# Before run this check script, make sure you:
#   1. use xxd to generate corresponding
#     "unsigned char payload[]" in the socket simulator
#   2. use ktest-tool to extract each reconstructed file
#   3. Fix file path and env in this file (e.g. ${REPLAY_BASE})
#################################################################
if [ -z $1 ]; then
  echo "${0}" '${ITER}'
  exit -1
fi
ITER=$1
source $(dirname $0)/klee-env.sh

REPLAY_BASE=replay.9manual.klee-out/test000001.ktest

prepass -assign-id -insert-ptwrite -ptwrite-cfg=${DATARECCFG} ${BASE_BC} ${PREPASS_BC}
cp ${PREPASS_BC} ${RUN_BC}
rm -rf ${KLEE_RECORD_OUT_DIR}
klee -save-final-module-path=${FREQ_BC} -solver-backend=stp -call-solver=false \
     -output-stats=false -output-istats=false -use-forked-solver=false \
     -output-source=false -write-kqueries -write-paths --libc=uclibc \
     --posix-runtime -env-file=env \
     -pathrec-entry-point="__klee_posix_wrapped_main" -ignore-posix-path=true \
     -use-independent-solver=false -oob-check=false -allocate-determ \
     -output-dir=${KLEE_RECORD_OUT_DIR} \
     ${RUN_BC} --posix-debug --unsafe -sock-handler apache-60324 \
     -conc-urandom ${REPLAY_BASE}._dev_urandom \
     -remap-file /etc/group ${REPLAY_BASE}.group \
     -remap-file /etc/passwd ${REPLAY_BASE}.passwd \
     -remap-file /mnt/storage/gefeizuo/hase/bugbase/apache-60324/httpd-2.4.6/../install/conf/httpd.conf ${REPLAY_BASE}.httpd.conf \
     -remap-file /mnt/storage/gefeizuo/hase/bugbase/apache-60324/install/conf/mime.types ${REPLAY_BASE}.mime.types \
     -X
# --posix-debug 
#-all-external-warnings 
cp ${FREQ_BC} ${PREPASS_BC} ${DATARECCFG} ${KLEE_RECORD_OUT_DIR} 
