KLEE_BC:=python.bc
PERF_BC:=python.bc
SRCDIR:=cpython
#KLEE_ARGS+=-run-in-dir=build
APP_ARGS=-unsafe -argv0 build/python $(1)
REPLAY_ARGS:=-sym-file readahead.py
SOLVERTIMEOUT:=30s
ORACLE_KTEST:=klee/oracle.ktest
ELF_APP:=build/python
INPUT_FILES:=readahead.py

${SRCDIR}:
${SRCDIR}/configure: ${SRCDIR}
	git submodule update --init ${SRCDIR}
	patch -p1 -d ${SRCDIR} < python.klee.patch
build: ${SRCDIR}/configure
	mkdir -p build
	cd build && CXX=wllvm++ CC=wllvm ../${SRCDIR}/configure --disable-profiling --disable-optimizations --disable-toolbox-glue --disable-ipv6 --disable-big-digits--without-valgrind --without-tsc --without-gcc LDFLAGS='-Wl,-no-export-dynamic -static' LINKFORSHARED=" " --disable-shared
	cp Setup.local build/Modules/Setup.local
	make -C build -j`nproc`
build/%: build;
python.bc: build/python
	extract-bc $<
	cp $<.bc $@

build-clean:
	rm -rf ${NAME} build ${ALL_BC}

ALL_BC:= ${KLEE_BC} ${PERF_BC}

include ../utils/Makefile.klee.rules
