# Mariadb-MDEV-86812
* Crash Version: 10.2.7
* Result: Deadlock (caused by assertion fail)
* Behaviour: Server hangs
* Sketch: 
    - Assertion `strcmp(share->unique_file_name,filename) || share->last_version' failed. 
    - In mi_open (name=0x7fda624afdb0 "./test/t1#P#p0", mode=2, open_flags=1106) at /data/src/10.0/storage/myisam/mi_open.c:122
* Fixed Version: 10.2.19