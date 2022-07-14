use Weight_OnDB;
show tables;

CREATE TABLE planTBL(
	num	INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	id varchar(10) NOT NULL,
	workoutNum varchar(10) NOT NULL,
	name varchar(30)NOT NULL,
	category varchar(10) NOT NULL,
	setCount INT,
	setWeight INT,
	memo TEXT,
    complete varchar(10),
	save_day varchar(50),
	done_day varchar(50),
	FOREIGN KEY(id) REFERENCES userTBL(id) ON DELETE CASCADE
)default CHARSET=utf8;

DROP TABLE planTBL;

desc planTBL;

INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,memo,save_day) VALUES ('admin9','B001','덤벨 컬', '팔', '1', '30', '2022-06-29');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,memo,save_day) VALUES ('admin9','B001','덤벨 컬', '팔', '2', '30', '2022-06-29');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,memo,save_day) VALUES ('admin9','B001','덤벨 컬', '팔', '3', '30', '2022-06-29');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,memo,save_day) VALUES ('admin9','B001','덤벨 컬', '팔', '4', '30', '2022-06-29');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,memo,save_day) VALUES ('admin9','B001','덤벨 컬', '팔', '5', '30', '2022-06-29');

INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '1', '30', 'Done', '', '2022-07-03', '2022-07-03');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '2', '30', 'Done', '', '2022-07-03', '2022-07-03');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '3', '30', 'Done', '', '2022-07-03', '2022-07-03');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '4', '30', 'Done', '', '2022-07-03', '2022-07-03');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '5', '30', 'Done', '', '2022-07-03', '2022-07-03');

INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '1', '30', 'Done', '', '2022-07-04', '2022-07-04');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '2', '30', 'Done', '', '2022-07-04', '2022-07-04');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '3', '30', 'Done', '', '2022-07-04', '2022-07-04');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '4', '30', 'Done', '', '2022-07-04', '2022-07-04');
INSERT INTO planTBL(id,workoutNum,name,category,setCount,setWeight,complete,memo,save_day,done_day) VALUES ('admin1','C001','덤벨 플렛 벤치프레스', '가슴', '5', '30', 'Done', '', '2022-07-04', '2022-07-04');

SELECT * FROM planTBL;

SELECT * FROM planTBL WHERE save_day='2022-07-01' ORDER BY num asc;

SELECT * FROM planTBL WHERE save_day='2022-07-01' ORDER BY num desc;

SELECT * FROM planTBL WHERE id = 'admin9' and save_day= '2022-07-01' and complete is null ORDER BY num ASC;

SELECT done_day FROM planTBL where id = 'admin9' ORDER BY done_day ASC;

SELECT DISTINCT done_day FROM planTBL where id = 'admin1' ORDER BY done_day ASC;

SELECT * FROM planTBL WHERE id = 'admin1' and done_day= '2022-07-04' ORDER BY num ASC;

DELETE FROM planTBL WHERE id = 'admin1' and done_day= '2022-07-04';
