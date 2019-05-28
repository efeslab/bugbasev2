mysql -u root -psecret -e 'DROP DATABASE roundcube;'
mysql -u root -psecret -e 'CREATE DATABASE roundcube;'
mysql -u root -psecret -e "CREATE USER 'mysqluser'@'localhost' IDENTIFIED BY 'a'";
mysql -u root -psecret -e "grant all on roundcube.* to 'mysqluser'@'localhost'";
mysql -u mysqluser -pa roundcube < dump.dmp
mysqlimport --ignore-lines=1 --fields-terminated-by=';' --verbose --local -u root -psecret roundcube users.csv
mysqlimport --ignore-lines=1 --fields-terminated-by=';' --verbose --local -u root -psecret roundcube contacts.csv
mysqlimport --ignore-lines=1 --fields-terminated-by=';' --verbose --local -u root -psecret roundcube identities.csv
mysqlimport --ignore-lines=1 --fields-terminated-by=';' --verbose --local -u root -psecret roundcube contactgroups.csv
