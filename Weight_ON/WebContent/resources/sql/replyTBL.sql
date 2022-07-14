use Weight_OnDB;
show tables;

CREATE TABLE replyTBL (
	num INT NOT NULL,
	r_num INT NOT NULL,
    id VARCHAR(10) NOT NULL,
    name VARCHAR(10) NOT NULL,    
    comment TEXT NOT NULL,
    regist_day VARCHAR(30),
    FOREIGN KEY(num) REFERENCES boardTBL(num) ON DELETE CASCADE,
    FOREIGN KEY(id) REFERENCES userTBL(id) ON DELETE CASCADE
)default CHARSET=utf8;

DROP TABLE replyTBL;

desc replyTBL;

SELECT * FROM replyTBL;