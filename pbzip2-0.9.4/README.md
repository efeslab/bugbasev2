## Pbzip2 ##
### Information for klee record/replay
1. How to build:
```bash
tar xf pbzip2-0.9.4.tar.gz
cd pbzip2-0.9.4/
mkdir lib
tar xf ../lib/bzip2-1.0.6.tar.gz -C lib
cd lib/bzip2-1.0.6/
make
cd ../../
# use wllvm++
patch < ../patches/Makefile.patch
# insert sleep to trigger the bug
patch < patches/pbzip2-0.9.4.patch
make
extract-bc pbzip2
cp pbzip2.bc ../
cd ..
bash klee-record.sh 0
bash klee-replay.sh 0
```
2. How to reproduce using elf
```bash
./pbzip2 -b1 -k -f -p2 test.tar
```
3. Note that the Makefile of bzip2 is already patched to use wllvm, but two
   patches are required for pbzip2.
4. Note that the input is not involved in branches, thus there is no path
   constraint nor solver call during the first replay. This is a very simple
   bug. A normal tar I generated normally is also attached in the repo.

###Bug in version 0.9.4, no bug report found ###

#### Bug type : order violation ####

##### Functions involved : ######
 * main in pbzip2.cpp
 * consumer in pbzip2.cpp


###### Buggy interleaving : ######
|thread 1: void main(...)|thread 2: void \*consumer(void \*q)|
|---| ---|
|...||
|ret = pthread_create(&con, NULL, consumer, fifo);||
|...|...|
|pthread_join(output, NULL);||
|...|if (allDone == 1) {|
|fifo->empty = 1;||
|//reclaim memory||
|queueDelete(fifo);||
|fifo = NULL;||
||&nbsp;&nbsp;&nbsp;&nbsp;pthread_mutex_unlock(fifo->mut);|
||}|

##### Explanation : #####
The main threads creates consumers to compress the data, but it only waits on the output thread.
If a consumer has not finished its task before the output thread has finished, the main thread will delete the fifo object.
Therefore, when unlocking the mutex, a consumer can access a null pointer and will segfault

##### Credits #####
This is from [dslab-epfl](https://github.com/dslab-epfl/bugbase)
Thanks to jieyu for having documented this bug in his [concurrency bugs repository](https://github.com/jieyu/concurrency-bugs)
More information are also available there.
