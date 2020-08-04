CREATE DATABASE testschema;
USE testschema;

CREATE TABLE t1 (
	id int not null auto_increment,
	groupid int,
	primary key (id, groupid)
)partition by list(groupid) (partition p1 values in (1), partition p2 values in (2));
 
ALTER TABLE t1 truncate partition p1; 

INSERT INTO t1 partition (p1) (groupid) SELECT 1;
 
#cleanup
DROP TABLE t1;