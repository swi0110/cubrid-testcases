set system parameters 'alter_table_change_type_strict=yes';
CREATE TABLE 테이블(칼럼1 char(11));
INSERT INTO 테이블 VALUES ('2010-01-32'),('2010-01-02'),('2010-02-29'); 
ALTER TABLE 테이블 CHANGE 칼럼1 칼럼2 date unique;
drop class  테이블;
set system parameters 'alter_table_change_type_strict=no';
CREATE TABLE 테이블(칼럼1 char(11));
INSERT INTO 테이블 VALUES ('2010-01-32'),('2010-01-02'),('2010-02-29'); 
ALTER TABLE 테이블 CHANGE 칼럼1 칼럼2 date unique; 
SELECT * FROM 테이블  order by 1;
drop class  테이블;