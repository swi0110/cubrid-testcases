/*
Test Case: delete & delete
Priority: 1
Reference case:
Author: Ray

Test Plan: 
Test DELETE locks (X_LOCK on instance) if the delete instances of the transactions are overlapped (with multi-tables deletion by using INNER JOIN)

Test Scenario:
C1 delete, C2 delete, the affected rows are overlapped
C1 delete instances are included in the instances from C2 delete 
C1 commit, C2 commit
Metrics: data size = small, join query = inner join, where clause = simple (multiple columns), DELETE state = multiple tables deletion

Test Point:
1) C2 needs to wait C1 completed
2) The data affected from C1 will be deleted, the overlapped C2 instances won't be deleted but the remaining(non-overlapped) will
   (i.e.the version will be updated, the C2 search condition is partially satisfied) 

NUM_CLIENTS = 3
C1: delete from table t1 inner join table t2;  
C2: delete from table t1 inner join table t2;  
C3: select on table t1; C3 is used to check the updated result
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: DROP TABLE IF EXISTS t2;
C1: CREATE TABLE t1(id INT, col VARCHAR(10));
C1: CREATE TABLE t2(id INT, col VARCHAR(10));
C1: INSERT INTO t1 VALUES(1,'abc'),(2,'def'),(3,'ghi'),(4,'jkl'),(5,'mno'),(6,'pqr'),(7,'abc');
C1: INSERT INTO t2 VALUES(1,'stu'),(2,'vwx'),(3,'yzab'),(4,'abc'),(5,'def'),(6,'jkl'),(7,'mno'),(8,'pqr');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: DELETE a,b FROM t1 a INNER JOIN t2 b ON a.id = b.id WHERE a.id = 5 or a.col = 'abc';
MC: wait until C1 ready;
C2: DELETE a,b FROM t1 a INNER JOIN t2 b ON a.id = b.id WHERE b.id = 1 or b.id = 7 or a.col = 'mno' or b.id < 3; 
/* expect: C2 needs to wait until C1 completed */
MC: wait until C2 blocked;
/* expect: C1 select - t1 id = 1,5,7 are deleted, t2 id = 1,5,7 are deleted */
C1: SELECT * FROM t1 order by 1,2;
C1: SELECT * FROM t2 order by 1,2;
C1: rollback;
/* expect: 2 rows deleted message should be generated once C2 ready, 
   C2 select - t1 id = 1,2,5,7 are deleted, t2 id = 1,2,5,7 are deleted */
MC: wait until C2 ready;
C2: SELECT * FROM t1 order by 1,2;
C2: SELECT * FROM t2 order by 1,2;
C2: commit;
/* expect: the instances of t1, t2 id = 1,2,5,7 are deleted */
C3: select * from t1 order by 1,2;
C3: select * from t2 order by 1,2;

C1: quit;
C2: quit;
C3: quit;

