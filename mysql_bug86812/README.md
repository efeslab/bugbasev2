# MySQL bug86812
* Result: Deadlock
* Note: manually generate a seg fault to stop from the container exit normally because MySQL has deadlock detection and will rollback to finish the command normally