FROM mysql:5.6

COPY * /

RUN apt-get update
RUN apt-get install -y gcc
RUN gcc -o dump dump.c
# RUN chmod +x prepare.sh && chmod +x reproduce.sh

CMD sleep 1 && bash prepare.sh && bash reproduce.sh