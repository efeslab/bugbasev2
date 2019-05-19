docker stop bug82127
echo 'y' | docker system prune
docker build -t zry1998530/mysql82127 .
docker run --name bug82127 -e MYSQL_ROOT_PASSWORD=secret --rm -itd zry1998530/mysql82127