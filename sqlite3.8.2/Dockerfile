FROM debian:latest
RUN apt-get update && apt-get install -y gcc libc6-dev make
RUN apt-get update && apt-get install -y tcl-dev tk-dev
RUN apt-get update && apt-get install -y file
COPY SQLite-27392118 /tmp/sqlite
COPY test.sqlite /tmp/test.sqlite
WORKDIR /tmp/sqlite
RUN ./configure && make && make install
WORKDIR /tmp
CMD sqlite3 < test.sqlite