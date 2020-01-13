java -jar ReproduceMemcachedSegfault-1.0-SNAPSHOT-shaded.jar sammy test localhost 11211 > stdout.txt 2 > stderr.txt &
memcached -S -v -u root