use Weight_OnDB;
show tables;

CREATE TABLE boardTBL (
	num INT NOT NULL AUTO_INCREMENT,
    id VARCHAR(10) NOT NULL,
    name VARCHAR(10) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    fileName VARCHAR(30),
    regist_day VARCHAR(30),
    hit INT,
    PRIMARY KEY(num),
    FOREIGN KEY(id) REFERENCES userTBL(id) ON DELETE CASCADE
)default CHARSET=utf8;

DROP TABLE boardTBL;

desc boardTBL;

SELECT * FROM boardTBL;