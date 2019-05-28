#!/bin/bash
# docker stop bug93646
# docker container rm bug93646
docker run --name bug93646 -e MYSQL_ALLOW_EMPTY_PASSWORD=1 --rm -itd zry1998530/mysql93646
docker exec -it bug93646 bash test.sh