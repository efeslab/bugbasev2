FROM mysql:5.6

COPY * /

RUN apt-get update && apt-get install -y gcc && gcc -o dump dump.c


CMD ["sh", "-c", "bash deadlock_produce.sh && ulimit -c unlimited && ./dump"]