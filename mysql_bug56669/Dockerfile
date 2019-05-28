FROM ubuntu:12.04
COPY * /

# RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y alien
RUN alien -i MySQL-server-5.1.41-0.glibc23.x86_64.rpm
RUN apt-get install -y libmysqlclient-dev
RUN gcc tst56669.c -o tst -std=c99 `mysql_config --cflags --libs`
CMD ./tst