FROM mariadb:10.2.7

RUN apt-get update; true
RUN apt-get install -y php5 && apt-get install -y php5-mysql && apt-get install -y php5-curl

CMD ulimit -c unlimited && php -v