docker run --name mariadb8407 -e MYSQL_ALLOW_EMPTY_PASSWORD=1 --rm -itd maria8407
docker exec -it mariadb8407 bash query.sh