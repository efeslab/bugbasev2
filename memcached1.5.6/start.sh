memcached -S -v -u root &
java -jar ReproduceMemcachedSegfault-1.0-SNAPSHOT-shaded.jar sammy test localhost 11211