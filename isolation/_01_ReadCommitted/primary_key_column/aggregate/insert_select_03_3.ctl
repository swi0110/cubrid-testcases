/*
Test Case: insert & select
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/primary_key_column/aggregate/insert_select_01.ctl
Author: Rong Xu

Test Point:
there is expr and subquery in min max, there are unvacuumed data, and uncommitted update and insert at the same time
C1 update begin
               C2 insert begin
                              C3 select begin
                              C3 commit
               C2 commit
C1 commit

NUM_CLIENTS = 3
C3: select min(t1.id),max(t1.col) from t t1 left outer join (select min(t.col) as col from t where id>5) as t2 on t1.id=t2.col group by t2.col;
*/

MC: setup NUM_CLIENTS = 3;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t;
C1: create table t(id bigint primary key,col varchar(10));
C1: set @newincr=0;
C1: insert into t select (@newincr:=@newincr+1),(@newincr)%100 from db_class a,db_class b,db_class c,db_class d limit 10000;
C1: commit;
C1: update t set id=id-1;
C1: commit;
MC: wait until C1 ready;

/* test case */
C1: update t set id=id+10000 where id%2=0;
C2: insert into t select id+20000,col from t where id%2=1;
C3: select min(t1.id),max(t1.col) from t t1 left outer join (select min(t.col) as col from t where id>5) as t2 on t1.id=t2.col group by t2.col order by 1;
C3: commit work;
MC: sleep 5;
MC: wait until C3 ready;
C2: rollback;
MC: wait until C2 ready;
C1: commit;
C1: select count(*) from t;
C1: commit;

C3: quit;
C2: quit;
C1: quit;

