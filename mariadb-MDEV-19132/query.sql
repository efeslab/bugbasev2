CREATE DATABASE test;
USE test;
CREATE TABLE IF NOT EXISTS `test` (
    `id` INT(10) UNSIGNED NOT NULL,
    PRIMARY KEY (`id`)
)
ENGINE=InnoDB;
 
# CRASHER CODE
SELECT test.id
FROM   test
 
LEFT JOIN test AS join2
     LEFT JOIN test AS join3
             LEFT JOIN test AS join4
                  ON NULL AND
                     join4.id
          ON FALSE
     ON FALSE
 
LEFT JOIN test AS join1
     ON FALSE;
 
# CLEAN
DROP TABLE `test`;