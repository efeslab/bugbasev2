docker run --name mariadb17522 -e MYSQL_ALLOW_EMPTY_PASSWORD=1 --rm -it maria17522 &
fg
docker exec -i mariadb17522 perl ./MariaDBInsertDuplicateUpdateDeadlock.pl