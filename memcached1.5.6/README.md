# Memcached version 1.5.6

* type : segfault when sasl enabled and using the java spymemcached

## Important details

* The bug is reproduced with a java .jar file constantly making connections with invalid user credentials

* Need to start with the memcached server with -S (SASL) argument in parallel
