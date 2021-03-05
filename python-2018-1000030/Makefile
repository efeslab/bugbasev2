KLEE_BC:=python.bc
PERF_BC:=python.bc
SRCDIR:=cpython
#KLEE_ARGS+=-run-in-dir=build
APP_ARGS=$(1)
POSIX_ARGS:=-unsafe -argv0 build/python
REPLAY_POSIX_ARGS:=-sym-file readahead.py
SOLVERTIMEOUT:=30s
ORACLE_KTEST:=klee/oracle.ktest
ELF_APP:=build/python
INPUT_FILES:=readahead.py

${SRCDIR}/configure:
	git submodule update --init --checkout -f ${SRCDIR}
	patch -p1 -N -r - -d ${SRCDIR} < python.klee.patch
build: ${SRCDIR}/configure
	mkdir -p build
	cd build && CXX=wllvm++ CC=wllvm ../${SRCDIR}/configure --disable-profiling --disable-optimizations --disable-toolbox-glue --disable-ipv6 --disable-big-digits--without-valgrind --without-tsc --without-gcc LDFLAGS='-Wl,-no-export-dynamic -static' LINKFORSHARED=" " --disable-shared
	cp Setup.local build/Modules/Setup.local
	make -C build -j`nproc`
	build/python readahead.py || true
build/%: build;
python.bc: build/python
	extract-bc $<
	cp $<.bc $@

define klee_prerequisite=
@rm -rf /tmp/readahead.txt
endef
CUSTOM_CLEAN:=rm-output
.PHONY: rm-output
rm-output:
	$(klee_prerequisite)

build-clean:
	rm -rf ${NAME} build ${ALL_BC}

ALL_BC:= ${KLEE_BC} ${PERF_BC}

include ../utils/Makefile.klee.rules
