# Mariadb-MDEV-17522
- Behavior: Race Condition: Deadlock
- Detail: INSERT ON DUPLICATE KEY UPDATE on table with unique key causes deadlocks
- Root Cause: Invalid pointer dereference.
- Sketch: 
- Fix version: 10.3.11