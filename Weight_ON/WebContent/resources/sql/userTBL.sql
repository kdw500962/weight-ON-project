use Weight_OnDB;
show tables;

CREATE TABLE userTBL(
	id varchar(10) NOT NULL,
	password varchar(10) NOT NULL,
	name varchar(10) NOT NULL,
	gender varchar(4),
	birth varchar(10),
	mail varchar(30),
	phone varchar(20),
	address varchar(90),
	id_group varchar(10),
	regist_day varchar(50),
	primary key(id)
)default CHARSET=utf8;

DROP TABLE userTBL;

desc userTBL;

SELECT * FROM userTBL;

INSERT INTO userTBL(id,password,name,id_group) VALUES('admin','1234','관리자','관리자');
INSERT INTO userTBL(id,password,name) VALUES('admin1','1234','aab');
INSERT INTO userTBL(id,password,name) VALUES('admin2','1234','aac');
INSERT INTO userTBL(id,password,name) VALUES('admin3','1234','aad');
INSERT INTO userTBL(id,password,name) VALUES('admin4','1234','aaf');
INSERT INTO userTBL(id,password,name) VALUES('admin5','1234','aag');
INSERT INTO userTBL(id,password,name) VALUES('admin6','1234','aah');
INSERT INTO userTBL(id,password,name) VALUES('admin7','1234','aai');
INSERT INTO userTBL(id,password,name) VALUES('admin8','1234','aai');
INSERT INTO userTBL(id,password,name) VALUES('admin9','1234','aai');