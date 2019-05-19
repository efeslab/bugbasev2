FROM mariadb:10.0.15

# ENV MYSQL_ROOT_PASSWORD=secret
# ENV MYSQL_USER=root
# ENV MYSQL_PASSWORD=secret
# ENV MYSQL_DATA_DIR=/var/lib/mysql \
#     MYSQL_RUN_DIR=/run/mysqld \
#     MYSQL_LOG_DIR=/var/log/mysql

COPY query.sh /

# ENV MYSQL_ROOT_PASSWORD secret


# CMD bash query.sh

#CMD bash /docker-entrypoint-initdb.d/query.sh