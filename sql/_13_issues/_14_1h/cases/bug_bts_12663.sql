--+holdcas on;
set system parameters 'dont_reuse_heap_file=yes';
drop if exists t;
create table t(col1 int auto_increment,col2 clob);
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2)) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2),col1) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by col1,clob_to_char(col2)) from t order by 1,2,3;
drop t;

create table t(col1 int default 3,col2 clob);
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2)) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2),col1) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by col1,clob_to_char(col2)) from t order by 1,2,3;
drop t;

create table t(col1 int auto_increment,col2 clob);
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2)) from t order by 1,2,3;
select clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2),col1) from t order by 1,2;
select col1,clob_to_char(col2) ,row_number() over(partition by col1,clob_to_char(col2)) from t order by 1,2,3;
alter table t modify col1 int default 3;
insert into t(col2) values('cubrid'),('mysql'),('oracle'),('kingbase'),('informix'),('db2');
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2)) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by clob_to_char(col2),col1) from t order by 1,2,3;
select col1,clob_to_char(col2) ,row_number() over(partition by col1,clob_to_char(col2)) from t order by 1,2,3;
drop t;

create table t(col1 int auto_increment,col2 blob);
insert into t(col2) values(B'1000'),(B'1001'),(B'1010'),(B'1011'),(B'1100');
insert into t(col2) values(B'1000'),(B'1001'),(B'1010'),(B'1011'),(B'1100');
select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2)) from t order by 1,2,3;
select blob_to_bit(col2),col1 ,row_number() over(partition by blob_to_bit(col2),col1) from t order by 1,2,3;
select col1,blob_to_bit(col2) ,row_number() over(partition by col1,blob_to_bit(col2)) from t order by 1,2,3;
select row_number from (select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2)) row_number from t) order by 1;
alter table t modify col1 int default 3;
insert into t(col2) values(B'1000'),(B'1001'),(B'1010'),(B'1011'),(B'1100');
select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2)) from t order by 1,2,3;
select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2),col1) from t order by 1,2,3;
select col1,blob_to_bit(col2) ,row_number() over(partition by col1,blob_to_bit(col2)) from t order by 1,2,3;
select row_number from (select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2)) row_number from t) order by 1;
select row_number from (select col1,blob_to_bit(col2) ,row_number() over(partition by blob_to_bit(col2),col1) row_number from t) order by 1;
drop t;
set system parameters 'dont_reuse_heap_file=no';
--+holdcas off;
