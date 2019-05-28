CREATE DATABASE test;
USE test;
SET NAMES utf8;
CREATE TABLE t1 (
  `supplierId` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `supplierName` VARCHAR(128) NOT NULL,
  `supplierCaps` TEXT NOT NULL,
  `supplierSentToday` SMALLINT(6) NOT NULL,
  `supplierCapToday` SMALLINT(6) GENERATED ALWAYS AS (CONCAT('x',DAYNAME("2018-04-26"))) VIRTUAL,
  PRIMARY KEY (`supplierId`)
);
 
INSERT INTO t1 (`supplierName`, `supplierCaps`, `supplierSentToday`) VALUES ('TFLI Ltd', 'foo', '0');
INSERT INTO t1 (`supplierName`, `supplierCaps`, `supplierSentToday`) VALUES ('TFLI Ltd', 'bar', '0');
 
# Cleanup
DROP TABLE t1;