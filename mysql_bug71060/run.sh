docker stop bug71060
echo 'y' | docker system prune
docker build -t zry1998530/mysql71060 .
docker run --name bug71060 -e MYSQL_ROOT_PASSWORD=secret --rm -itd zry1998530/mysql71060
