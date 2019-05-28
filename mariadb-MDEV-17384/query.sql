CREATE DATABASE test;
USE test;
CREATE TABLE `bugs` (`bug_id` int NOT NULL PRIMARY KEY, `product_id` int NOT NULL);
INSERT INTO `bugs` VALUES (45199,1184);
 
CREATE TABLE `maintainer` (`product_id` int NOT NULL,`userid` int NOT NULL, PRIMARY KEY (`product_id`,`userid`));
INSERT INTO `maintainer` VALUES (1184,103),(1184,624),(1184,1577),(1184,1582);
 
CREATE TABLE `product_groups` (`id` int NOT NULL  PRIMARY KEY,`name` varchar(64));
CREATE TABLE `products` (`id` int NOT NULL PRIMARY KEY, `name` varchar(64));
 
CREATE TABLE `profiles` ( `userid` int NOT NULL PRIMARY KEY, `login_name` varchar(255));
INSERT INTO `profiles` VALUES (103,'foo'),(624,'foo'),(1577,'foo'),(1582,'foo');
 
select (
  select login_name from profiles where userId = (
    select userid from maintainer where product_id = bugs.product_id
    union
    select userid from maintainer where product_id = (
      select id from products where name = (select name from product_groups where id = bugs.product_id)) limit 1 ) 
) from bugs where (bugs.bug_id=45199);