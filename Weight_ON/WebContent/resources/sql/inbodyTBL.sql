use Weight_OnDB;
show tables;

CREATE TABLE inbodyTBL(
	num	INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	id varchar(10) NOT NULL,
	weight varchar(10),
	bodyFat varchar(10),
    muscleMass varchar(10),
	save_day varchar(50),
	FOREIGN KEY(id) REFERENCES userTBL(id) ON DELETE CASCADE
)default CHARSET=utf8;

DROP TABLE inbodyTBL;

desc inbodyTBL;

SELECT * FROM inbodyTBL;