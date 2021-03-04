KLEE_BC:=sqlite3.bc
PERF_BC:=fuzzcheck.bc
VERSION:=71f97f0f
NAME:=SQLite-${VERSION}
SRCTAR:=${NAME}.tar.gz
# APP_ARGS should be a Makefile function
APP_ARGS=-init $(word 1, $(1))
REPLAY_POSIX_ARGS:=-sym-file test.sqlite
SOLVERTIMEOUT?=10s
ELF_APP:=${NAME}/build/sqlite3
INPUT_FILES:=test.sqlite

${SRCTAR}:
	wget "https://www.sqlite.org/src/tarball/${VERSION}/${SRCTAR}"
${NAME}/build: ${SRCTAR}
	tar xf ${SRCTAR}
	mkdir -p ${NAME}/build
	cd ${NAME}/build && CC=wllvm ../configure --enable-debug --disable-readline --disable-threadsafe --disable-shared --enable-static
	make -C ${NAME}/build -j`nproc` all
	make -C ${NAME}/build -j`nproc` fuzzcheck

${NAME}/build/%: ${NAME}/build;
%.bc: ${NAME}/build/%
	extract-bc $<
	cp $<.bc $@

build-clean:
	rm -rf ${NAME} ${ALL_BC}

ALL_BC:= ${KLEE_BC} ${PERF_BC}

include ../utils/Makefile.klee.rules
