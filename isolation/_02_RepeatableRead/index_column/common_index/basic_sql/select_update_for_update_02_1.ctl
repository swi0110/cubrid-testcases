/*
Test Case: select for update & update
Priority: 1
Reference case:
Isolation Level: Repeatable Read
Author: Ray

Test Plan: 
Test MVCC behaviors for 'FOR UPDATE' clause within common index schema 

Test Scenario:
C1 select for update, C2 update, the affected rows are not overlapped
C2 update affect C1 (on unique key column)
C1 commit, C2 commit
Metrics: data size = small, where clause = simple, index = pk, DELETE state = single table

Test Point:
1) C2 will be waiting (Locking Test)
2) C1 and C2 can only see the its own deletion but not other transactions update  (Visibility Test)

NUM_CLIENTS = 3
C1: select from table t1 for update;  
C2: select from table t1;  
C3: select on table t1; C3 is used to check the updated result
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level repeatable read;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: CREATE TABLE t1(id INT PRIMARY KEY, col VARCHAR(10));
C1: INSERT INTO t1 VALUES(1,'abc'),(2,'def'),(3,'ghi'),(4,'jkl'),(5,'mno'),(6,'pqr');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: SELECT * FROM t1 WHERE id = 1 FOR UPDATE;
MC: wait until C1 ready;

C2: UPDATE t1 SET id = 1 WHERE id = 2;
/* expect: C2 needs to wait */
MC: wait until C2 blocked;
C1: UPDATE t1 SET id = 7 WHERE id = 1;
MC: wait until C1 ready;
C1: COMMIT;

MC: wait until C2 ready;
/* expect: C2 select - id = 1,2 is not updated */
C2: SELECT * FROM t1 order by 1,2;
MC: wait until C2 ready;
C2: commit;
MC: wait until C2 ready;

/* expect: the instances of id = 1 is update */
C3: select * from t1 order by 1,2;
MC: wait until C3 ready;


C1: quit;
C2: quit;
C3: quit;

