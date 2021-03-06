--scenario 1
drop table if exists tbl1;
drop table if exists tbl2;
CREATE TABLE tbl1 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
CREATE TABLE tbl2 (id INT AUTO_INCREMENT(100,1), last_id INT);
CREATE TRIGGER t1 AFTER INSERT ON tbl1 EXECUTE INSERT INTO tbl2 VALUES(NULL, LAST_INSERT_ID());
INSERT INTO tbl1 VALUES(NULL);
SELECT LAST_INSERT_ID();

--scenario 2
drop table if exists tbl1;
drop table if exists tbl2;
CREATE TABLE tbl1 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
CREATE TABLE tbl2 (id INT AUTO_INCREMENT(100,1), last_id INT);
CREATE TRIGGER t1 BEFORE INSERT ON tbl1 EXECUTE INSERT INTO tbl2 VALUES(NULL, LAST_INSERT_ID());
INSERT INTO tbl1 VALUES(NULL);
SELECT LAST_INSERT_ID();

--scenario 3
drop table if exists tbl1;
drop table if exists tbl2;
CREATE TABLE tbl1 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
CREATE TABLE tbl2 (id INT AUTO_INCREMENT(100,1), last_id INT);
CREATE TRIGGER t1 BEFORE INSERT ON tbl1 EXECUTE INSERT INTO tbl2 VALUES(NULL, LAST_INSERT_ID());
INSERT INTO tbl1 VALUES(NULL);
INSERT INTO tbl2 VALUES(NULL,2);
INSERT INTO tbl1 VALUES(NULL);
SELECT LAST_INSERT_ID();
SELECT * FROM tbl2 order by 1;

--scenario 4
drop table if exists tbl1;
drop table if exists tbl2;
CREATE TABLE tbl1 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
CREATE TABLE tbl2 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
INSERT INTO tbl1 VALUES(NULL);
SELECT LAST_INSERT_ID();
INSERT INTO tbl2 VALUES(NULL);
SELECT LAST_INSERT_ID();

--scenario 5
drop table if exists tbl1;
drop table if exists tbl2;
CREATE TABLE tbl1 (id INT AUTO_INCREMENT NOT NULL PRIMARY KEY);
CREATE TABLE tbl2 (id INT AUTO_INCREMENT(100,1), last_id INT);
CREATE TRIGGER t1 AFTER INSERT ON tbl1 EXECUTE INSERT INTO tbl2 VALUES(NULL, LAST_INSERT_ID());
INSERT INTO tbl1 VALUES(NULL);
INSERT INTO tbl1 VALUES(2);
INSERT INTO tbl1 VALUES(3);
INSERT INTO tbl1 VALUES(4);
INSERT INTO tbl1 VALUES(NULL);
SELECT LAST_INSERT_ID();
SELECT * FROM tbl2 order by 1;

drop table if exists tbl1;
drop table if exists tbl2;
