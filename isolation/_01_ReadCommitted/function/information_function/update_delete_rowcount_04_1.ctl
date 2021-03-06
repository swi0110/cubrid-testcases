/*
Test Case: update & delete 
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/function/information_function/update_delete_rowcount_04.ctl
Author: Ray
Function: ROW_COUNT()

Test Plan: 
Test MVCC UPDATE/DELETE scenarios if using information function ROW_COUNT in the query
and the affected instances are overlapped

Test Scenario:
C1 update, C2 delete, the affected rows are overlapped (based on where clause)
C1's updates do not affect the C2's deletes
C1 selects ROW_COUNT, C2 selects ROW_COUNT
C1 commit, C2 commit
Metrics: data size = small, index = no index, where clause = simple, schema = single table

Test Point:
1) C2 needs to wait until C1 completed  
2) C1 instances should be updated, the row_count should be returned based on its own snapshot
   C2 instances should be deleted after reevaluation, the row_count should be returned after reevaluation

NUM_CLIENTS = 2
C1: update table t1;  select row_count from table t1; 
C2: delete from table t1;  select row_count from table t1; 
*/

MC: setup NUM_CLIENTS = 3;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t1;
C1: CREATE TABLE t1(id INT, col VARCHAR(10), tag VARCHAR(2));
C1: INSERT INTO t1 VALUES(1,'abc','A'),(2,'def','B'),(3,'ghi','C'),(4,'jkl','D'),(5,'mno','E'),(6,'pqr','F'),(7,'abc','G');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: UPDATE t1 SET col = 'abcd' WHERE col = 'def' or tag BETWEEN 'F' AND 'G';
MC: wait until C1 ready;
C2: DELETE FROM t1 WHERE id >= 2 and id <= 3;
/* expect: C2 needs to wait once C1 completed */
MC: wait until C2 blocked;
/* expect: C1 select - row_count = 3 (id=2,6,7)is returned */
C1: SELECT ROW_COUNT();
C1: commit;
/* expect: 2 rows (id=2,3)deleted message, C2 select - row_count = 2 is returned */
MC: wait until C2 ready;
C2: SELECT ROW_COUNT();
C2: commit;

C1: quit;
C2: quit;
