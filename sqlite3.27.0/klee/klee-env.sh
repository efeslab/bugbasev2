BASE_BC=sqlite3.bc
# RUN_BC is to unify the executable name. Note that different file name may lead
# to different path. For a single iteration record/replay, RUN_BC is not
# necessary since they will use the same ${PREPASS_BC} anyway. But to compare
# paths from different record (e.g. confirming the generated input could lead to
# the same path), the ${RUN_BC} is essential.
RUN_BC=run.bc
DATARECCFG=datarec.${ITER}.cfg
PREPASS_BC=sqlite3.prepass.${ITER}.bc
FREQ_BC=sqlite3.freq.${ITER}.bc
KLEE_RECORD_OUT_DIR=record.${ITER}.klee-out
KLEE_REPLAY_OUT_DIR=replay.${ITER}.klee-out
