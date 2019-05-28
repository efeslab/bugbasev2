FROM mysql:5.7.13

COPY * /
RUN chmod +x prepare.sh && chmod +x reproduce.sh

CMD ./prepare.sh && ./reproduce.sh