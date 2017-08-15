/*
Test Case: update & update
Priority: 1
Reference case:
Author: Mandy

Test Point:
A target record may be already locked and modified (updated or deleted) by another transaction. In this case:
1. C1 will lock all the rows one by one
2. C2 will lock the last row after C1 starts and before C1 locks it
Even C1 and C2 have overlaps and C2 starts after C1 starts, C2 is not blocked by C1. However, C1 is blocked by C2 when C1 try to get the lock of the last row. 
3. C2 commit, C1 is ready and abort.

NUM_CLIENTS = 3
C1: update all the rows one by one; blocked; abort
C2: update the last row after C1 starts and before C1 lock the last row; commit
C3: select on table t1, and C3 is used to check the update result
*/


MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t1;
C1: create table t1(id int primary key, col varchar(10)) partition by range (id) (partition p0 values less than (10), partition p1 values less than (20));
C1: insert into t1 values(1,'abc');insert into t1 values(3,'def');insert into t1 values(9,'abc');insert into t1 values(11,'gh');insert into t1 values(15,'def');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: update t1 set id=id+1 where sleep(2)=0 and id>0;
MC: sleep 2;
C2: update t1 set id=id+2 where id=15;
C2: select * from t1 order by 1,2;
MC: wait until C2 ready;
MC: wait until C1 blocked;
C2: commit;
MC: wait until C2 ready;
MC: wait until C1 ready;

C1: select * from t1 order by 1,2;
C1: commit;
MC: wait until C1 ready;

/* C1 abort, so we cannot see the update result of C2 */
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;

C3: commit;
C1: quit;
C2: quit;
C3: quit;

