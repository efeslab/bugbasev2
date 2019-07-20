# bugs-to-reproduce
This a list of bugs that have been reproduced or some pending bugs that can be hopefully reproduced after further studying. Every bug is described in a docker container.
## install docker and start docker
We utilize docker container to reproduce bugs. To install docker on ubuntu(or other linux system alike),
```shell
sudo apt-get install docker-engine -y
```
To start docker engine,
```shell
sudo service docker start
```
## build container
For each bug in the list,
```shell
cd [bug directory]
```
Each bug directory should have a Dockerfile in it, with which we could build docker container.
```shell
docker image build -t [bug directory or anything you want] .
```
Note: For mariadb bugs, inside the directory should have a build.sh in it, so we can just type 
```shell
bash build.sh
```
to build it with a tag named maria[bug number].
## reproduce bug using the container just built
```shell
docker run [bug directory]
```
Note: For mariadb bugs, inside the directory should have a run.sh, simply type 
```shell
bash run.sh
```
in the terminal will be able to reproduce that bug.
## expected output
After we run the container of bug, we should see some error message from the shell we just execute `docker run`. For now, since those bugs are very trivial, we are expected to get `segmentation fault`.
## pending bugs
For those bug directories with a dash in their name, that indicates we haven't worked them out but hopefully we will. Therefore, the container built on those bug directories doesn't make sense currently.
## MISC
To see the total number of bugs reproducible for now, run `bash NumOfBugs.sh` in terminal.
