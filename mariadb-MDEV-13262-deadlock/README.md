# Mariadb-MDEV-86812
* Crash Version: 10.2.7
* Result: Race Condition/Deadlock
* Note: manually generate a seg fault to stop from the container exit normally because MariaDB has deadlock detection and will rollback to finish the command normally
* Sketch: Two sessions altering one table, each one getting exclusive lock. (Lack of exact code here) 
* Fixed Version: 10.2.19