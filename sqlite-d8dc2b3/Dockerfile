FROM debian:latest
ARG checkin=4bb22940
RUN apt-get update && apt-get install -y gcc libc6-dev make gdb
RUN apt-get update && apt-get install -y tcl-dev tk-dev
RUN apt-get update && apt-get install -y file wget vim
WORKDIR /tmp
RUN wget https://www.sqlite.org/src/tarball/$checkin/SQLite-$checkin.tar.gz
RUN tar -xvf SQLite-$checkin.tar.gz && rm SQLite-$checkin.tar.gz
COPY test.sqlite /tmp/test.sqlite
WORKDIR /tmp/SQLite-$checkin
RUN ./configure && make && make install
WORKDIR /tmp
CMD sqlite3 < test.sqlite
