FROM mariadb:10.2.18

RUN apt-get update 
RUN apt-get install -y perl


COPY initData.sql /docker-entrypoint-initdb.d/
COPY MariaDBInsertDuplicateUpdateDeadlock.pl /

# CMD perl ./MariaDBInsertDuplicateUpdateDeadlock.pl

