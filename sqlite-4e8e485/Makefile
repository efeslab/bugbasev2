KLEE_BC:=sqlite3.bc
PERF_BC:=fuzzcheck.bc
ALL_BC:= ${KLEE_BC} ${PERF_BC}
VERSION:=97744701
# APP_ARGS should be a Makefile function
NAME:=SQLite-${VERSION}
APP_ARGS=-init $(word 1, $(1))
REPLAY_POSIX_ARGS:=-sym-file test.sqlite
SOLVERTIMEOUT?=15s
ORACLE_KTEST:=klee/oracle.ktest
ELF_APP:=build/sqlite3
INPUT_FILES:=test.sqlite

build: ${NAME}
	mkdir -p build
	cd build && CC=wllvm ../${NAME}/configure --enable-debug --disable-readline --disable-threadsafe --disable-shared --enable-static
	make -C build -j`nproc` all
	make -C build -j`nproc` fuzzcheck

build/%: build;
%.bc: build/%
	extract-bc $<
	cp $<.bc $@

build-clean:
	rm -rf build ${ALL_BC}

include ../utils/Makefile.klee.rules
