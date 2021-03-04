KLEE_BC:=php.bc
PERF_BC:=php.bc
VERSION:=7.1.6
NAME:=php-${VERSION}
SRCTAR:=${NAME}.tar.xz
APP_ARGS=$(1)
REPLAY_POSIX_ARGS:=-sym-file poc.php -sym-file data
ENVFILE:=php/php_env
SOLVERTIMEOUT:=30s
ORACLE_KTEST:=php/oracle.ktest
ELF_APP:=build/sapi/cli/php
INPUT_FILES:=poc.php data

${SRCTAR}:
	wget https://www.php.net/distributions/${SRCTAR}
${NAME}: ${SRCTAR}
	tar xf ${SRCTAR}
	patch -p1 -d ${NAME} < ${NAME}.klee.patch
build/%: ${NAME}
	mkdir -p build
	cd build && CC=wllvm ../${NAME}/configure --disable-all --disable-cgi --without-pcre-jit
	make -C build -j`nproc`

php.bc: build/sapi/cli/php
	extract-bc $<
	cp $<.bc $@

build-clean:
	rm -rf ${NAME} build ${ALL_BC}

ALL_BC:= ${KLEE_BC} ${PERF_BC}

include ../utils/Makefile.klee.rules
