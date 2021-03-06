--+ holdcas on;
set names utf8;
CREATE TABLE t (s1 STRING COLLATE utf8_en_cs, s2 STRING COLLATE utf8_tr_cs);
insert into t values('i','h');
insert into t values('a','A');
SELECT s1, s2 FROM t WHERE s1 > s2 + 'abc';
drop table t;
CREATE TABLE t (s1 STRING COLLATE utf8_en_cs, s2 STRING COLLATE utf8_tr_cs, s3 STRING COLLATE utf8_en_ci);
insert into t values('i','h','g');
SELECT s1, s2 FROM t WHERE s1 > s2 + s3;
drop table t;
set names iso88591;
commit;
--+ holdcas off;