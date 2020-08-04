# mariadb-MDEV-21310
- behavior: Segmentation Fault

- Affect version: 10.3,10.4,10.4.9,10.4.10

- description: An out of range error is produced when an INSERT is targeted at a partitioned table with a PARTITION clause to force the partition selection