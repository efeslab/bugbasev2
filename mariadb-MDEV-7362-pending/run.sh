 #!/bin/bash
docker run --name maria7362 -e MYSQL_ROOT_PASSWORD=secret --rm -itd maria7362 && docker exec maria7362 bash query.sh
