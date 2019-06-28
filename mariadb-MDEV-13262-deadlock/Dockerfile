FROM mariadb:10.2.7

COPY dump.c /

RUN apt-get update || true
RUN apt-get install -y gcc && gcc -o dump dump.c

COPY deadlock_produce.sh /

CMD ./dump