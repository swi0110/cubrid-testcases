--change the type of  a bit varying column to other types

create class coo(
        col1 bit varying(100),
        col2 bit varying(100),
        col3 bit varying(100),
        col4 bit varying(100),
        col5 bit varying(100),
        col6 bit varying(100),
        col7 bit varying(100),
        col8 bit varying(100),
        col9 bit varying(100),
        col10 bit varying(100),
        col11 bit varying(100),
        col12 bit varying(100),
        col13 bit varying(100),
        col14 bit varying(100),
        col15 bit varying(100),
        col16 bit varying(100),
        col17 bit varying(100),
        col18 bit varying(100),
        col19 bit varying(100),
	col20 bit varying(100)
);

insert into coo (col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, col11, col12, col13, col14,col15, col16, col17, col18, col19, col20)
 values(X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee');

insert into coo (col1, col2, col3, col4, col5, col6, col7, col8, col9, col10, col11, col12, col13, col14,col15, col16, col17, col18, col19, col20)
 values(X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee', X'aaa', X'bbb', X'ccc', X'ddd', X'eee');

show columns in coo;

alter table coo change col1 aaa char(20);
select aaa from coo order by 1;
alter table coo change col2 bbb nchar(20);
select bbb from coo order by 1;
alter table coo change col3 ccc nchar varying(20);
select ccc from coo order by 1;

alter table coo change col4 ddd bit(100);
select ddd from coo order by 1;
--change to the same type
alter table coo change col5 eee bit varying(100);
select eee from coo order by 1;

alter table coo change col6 fff numeric;
select fff from coo order by 1;
alter table coo change col7 ggg integer;
select ggg from coo order by 1;
alter table coo change col8 hhh smallint;
select hhh from coo order by 1;
alter table coo change col9 iii monetary;
select iii from coo order by 1;
alter table coo change col10 jjj float;
select jjj from coo order by 1;
alter table coo change col11 kkk double;
select kkk from coo order by 1;

alter table coo change col12 lll date;
select lll from coo order by 1;
alter table coo change col13 mmm time;
select mmm from coo order by 1;
alter table coo change col14 nnn timestamp;
select nnn from coo order by 1;

alter table coo change col15 ooo set;
select ooo from coo order by 1;
alter table coo change col16 ppp multiset;
select ppp from coo order by 1;
alter table coo change col17 qqq sequence;
select qqq from coo order by 1;
alter table coo change col18 rrr blob;
select rrr from coo order by 1;
alter table coo change col19 sss clob;
select sss from coo order by 1;

alter table coo change col20 ttt datetime;
select ttt from coo order by 1;

show columns in coo;

delete from coo;
drop table coo;


