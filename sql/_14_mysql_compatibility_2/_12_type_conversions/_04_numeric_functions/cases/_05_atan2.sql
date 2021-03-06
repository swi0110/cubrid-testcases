CREATE table alltypes(
int_col INTEGER,
float_col FLOAT,
double_col DOUBLE,
smallint_col SMALLINT,
date_col DATE,
time_col TIME,
timestamp_col TIMESTAMP,
datetime_col DATETIME,
monetary_col MONETARY,
numeric_col NUMERIC(12,4),
char_col char(255),
varchar_col varchar(255),
nchar_col nchar(255),
varnchar_col nchar varying(255),
bit_col bit(8),
varbit_col bit varying (255),
set_col set(integer),
sequence_col sequence(integer),
multiset_col multiset(integer, varchar(255)),
blob_col blob,
clob_col clob
);

insert into alltypes values(12345, 123.45, 1003.367, 123, date'2010-01-01', time'12:34:56', timestamp'2010-01-01 12:34:56 am', datetime'2010-01-01 12:34:56.123 am',1000, 123456.7890, '123', '123.45' ,N'123.45', N'123', b'01010101', b'111111111', {1,2,3,4,5} , {6,7,8,9}, {0,'a','b','c',13,14,15}, '123', '123');


select atan2(monetary_col,10.23) from alltypes;

select atan2(10.23,monetary_col) from alltypes;

select atan2(monetary_col,monetary_col) from alltypes;

select atan2(monetary_col,char_col) from alltypes;

select atan2(monetary_col,varchar_col) from alltypes;

select atan2(monetary_col,nchar_col) from alltypes;

select atan2(monetary_col,varnchar_col) from alltypes;


select atan2(numeric_col,10.23) from alltypes;

select atan2(10.23,numeric_col) from alltypes;

select atan2(numeric_col,char_col) from alltypes;

select atan2(numeric_col,varchar_col) from alltypes;

select atan2(numeric_col,nchar_col) from alltypes;

select atan2(numeric_col,varnchar_col) from alltypes;

select atan2(numeric_col,numeric_col) from alltypes;


select atan2(char_col,10.23) from alltypes;

select atan2(10.23,char_col) from alltypes;

select atan2(char_col,char_col) from alltypes;

select atan2(char_col,monetary_col) from alltypes;

select atan2(char_col,numeric_col) from alltypes;

select atan2(char_col,varchar_col) from alltypes;

select atan2(char_col,nchar_col) from alltypes;

select atan2(char_col,varnchar_col) from alltypes;


select atan2(varchar_col,10.23) from alltypes;

select atan2(10.23,varchar_col) from alltypes;

select atan2(varchar_col,varchar_col) from alltypes;

select atan2(varchar_col,monetary_col) from alltypes;

select atan2(varchar_col,numeric_col) from alltypes;

select atan2(varchar_col,varchar_col) from alltypes;

select atan2(varchar_col,nchar_col) from alltypes;

select atan2(varchar_col,varnchar_col) from alltypes;


select atan2(nchar_col,10.23) from alltypes;

select atan2(10.23,nchar_col) from alltypes;

select atan2(nchar_col,monetary_col) from alltypes;

select atan2(nchar_col,numeric_col) from alltypes;

select atan2(nchar_col,varchar_col) from alltypes;

select atan2(nchar_col,nchar_col) from alltypes;

select atan2(nchar_col,varnchar_col) from alltypes;


select atan2(varnchar_col,10.23) from alltypes;

select atan2(10.23,varnchar_col) from alltypes;

select atan2(varnchar_col,monetary_col) from alltypes;

select atan2(varnchar_col,numeric_col) from alltypes;

select atan2(varnchar_col,varchar_col) from alltypes;

select atan2(varnchar_col,nchar_col) from alltypes;

select atan2(varnchar_col,varnchar_col) from alltypes;


select if(atan2('123','10.5') = atan2(123,10.5), 'ok','nok');

select if(atan2('123.45',N'10.5') = atan2(123.45,10.5), 'ok','nok');

select if(atan2(N'123',N'10.5') = atan2(123,10.5),'ok','nok');

select if(atan2(N'123.45','10.5') = atan2(123.45,10.5),'ok','nok');

$varchar, $0.123, $varchar, $-0.123
select atan2(?,?) from db_root;

$varchar, $0.123, $varchar, $-0.123
select if (atan2(?,?) = atan2(0.123,-0.123), 'ok','nok') from db_root;

drop table alltypes;
