CREATE DATABASE test;
USE test;

CREATE TABLE `tab1` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `field2` set('option1','option2','option3','option4') NOT NULL,
  `field3` set('option1','option2','option3','option4','option5') NOT NULL,
  `field4` set('option1','option2','option3','option4') NOT NULL,
  `field5` varchar(32) NOT NULL,
  `field6` varchar(32) NOT NULL,
  `field7` varchar(32) NOT NULL,
  `field8` varchar(32) NOT NULL,
  `field9` int(11) NOT NULL DEFAULT '1',
  `field10` varchar(16) NOT NULL,
  `field11` enum('option1','option2','option3') NOT NULL DEFAULT 'option1',
  `v_col` varchar(128) AS (IF(field11='option1',CONCAT_WS(":","field1",field2,field3,field4,field5,field6,field7,field8,field9,field10), CONCAT_WS(":","field1",field11,field2,field3,field4,field5,field6,field7,field8,field9,field10))) PERSISTENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

alter table tab1 CHANGE COLUMN v_col `v_col` varchar(128);