#!/bin/bash
docker build -t zry1998530/mysql86812 .
docker run --name bug86812 -e MYSQL_ROOT_PASSWORD=secret --rm -itd zry1998530/mysql86812
