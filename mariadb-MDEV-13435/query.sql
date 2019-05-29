CREATE DATABASE test;
USE test;

CREATE TABLE `t1` (
  `id` int  NOT NULL ,
  `js` varchar(1000) NOT NULL,
  `t` time AS (cast(json_value(json_extract(js,concat('$.singleDay."',dayname(curdate()),'"')),'$.start') as time)) virtual);
 
insert  into `t1`(id,js) values (0,'{\"default\":{\"start\":\"00:00:00\",\"end\":\"23:59:50\"}}');
 
select * from t1;