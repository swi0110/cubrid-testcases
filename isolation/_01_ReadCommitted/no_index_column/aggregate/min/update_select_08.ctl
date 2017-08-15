/*
Test Case: update & select
Priority: 1
Reference case:
Author: Mandy

Test Point:
Test the visibility before commit and after commit
1. Reading queries can only have a look at data committed before the queries began
2. Uncommitted data are never seen
At the same time check update dose not block select

NUM_CLIENTS = 2
C1: update and select on table t1
C2: select on table t1 before C1 commit and after C1 commit
*/


MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t1;
C1: create table t1(id int, col varchar(10));
C1: insert into t1 values(1,'abc'),(2,'def'),(3,'abc'),(4,'ijk'),(1,'lmn'),(2,'aa');
C1: commit;
MC: wait until C1 ready;

/* test case */
C1: update t1 set id=null where id=1;
MC: wait until C1 ready;
/* get 1*/
C2: select min(id) from t1;
MC: wait until C2 ready;
C1: commit;
MC: wait until C1 ready;
/* get 2*/
C2: select min(id) from t1;
MC: wait until C2 ready;
C2: commit;
MC: wait until C2 ready;

C1: quit;
C2: quit;
