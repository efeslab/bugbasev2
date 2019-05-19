# !bin/bash
# mysql 5.6/5.7 bug 89539 
docker run --name bug89539 -e MYSQL_ROOT_PASSWORD=secret --rm -itd mysql:5.6 & # run mysql server in background
docker exec -it bug89539 mysql -uroot -psecret --prompt "$(echo -e '\\u@\\h \\d \xE2\x89\xBB ')"

