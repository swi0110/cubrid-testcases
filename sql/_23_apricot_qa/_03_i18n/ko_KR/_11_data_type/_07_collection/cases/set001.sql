--+ holdcas on;
set names utf8;
CREATE TABLE set_tbl ( col_1 set(int, char(1)  collate utf8_ko_cs_uca));
INSERT INTO set_tbl VALUES ({3,3,3,2,2,1,0,'탐','탐','탐','토','토','攄'});
INSERT INTO set_tbl VALUES ({NULL});
INSERT INTO set_tbl VALUES ({''});
SELECT * FROM set_tbl order by 1; 
SELECT CAST(col_1 AS MULTISET), CAST(col_1 AS LIST) FROM set_tbl order by 1; ;
drop table set_tbl;
set names iso88591;
commit;
--+ holdcas off;