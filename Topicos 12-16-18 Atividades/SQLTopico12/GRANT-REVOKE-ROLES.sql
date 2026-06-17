CREATE USER 'andre'@'localhost' IDENTIFIED BY 'senha123';

SELECT * FROM mysql.user;

CREATE USER 'andre2'@'localhost' IDENTIFIED BY'';

SELECT host, user
FROM mysql.user;

DROP USER 'andre2'@'localhost';

CREATE USER 'andre3'@'localhost' IDENTIFIED BY'';

GRANT CREATE,SELECT,INSERT,DELETE
ON *.*
TO 'andre3'@'localhost';

FLUSH PRIVILEGES;