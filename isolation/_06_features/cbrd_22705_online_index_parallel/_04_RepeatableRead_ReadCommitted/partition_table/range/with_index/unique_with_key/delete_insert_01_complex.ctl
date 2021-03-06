MC: setup NUM_CLIENTS = 3;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int,col varchar(10)) partition by range(id)(partition p1 values less than (10),partition p2 values less than (100));
C1: insert into t(id,col) values(null,null);
C1: create unique index idx on t(id,col) with online parallel 7;
C1: insert into t values(1,'abc');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: delete from t where id=1;
C1: insert into t values(1,'abc');
MC: wait until C1 ready;

C2: delete from t where id=1;
MC: wait until C2 blocked;

C3: insert into t values(1,'abc');
MC: wait until C3 blocked;

C1: commit;
MC: wait until C1 ready;
MC: wait until C2 ready;

C2: commit;
MC: wait until C2 ready;

MC: wait until C3 ready;
C3: commit;
MC: wait until C3 ready;


/* expected no datas */
C2: select * from t order by 1;
C2: commit;

C2: quit;
C1: quit;
C3: quit;
