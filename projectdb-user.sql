drop user 'api'@localhost;
create user 'api'@'localhost' identified by 'api';
grant all privileges on projectdb.* to 'api'@'localhost';
flush privileges;