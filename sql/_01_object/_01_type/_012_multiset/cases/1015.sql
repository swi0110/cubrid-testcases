-- [er]create table with MULTISET data type and insert bit data


CREATE CLASS t1(
   col1       MULTISET
);

INSERT INTO t1 VALUES (B'0001');

drop t1;