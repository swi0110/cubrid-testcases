/*
Test Case: delete & update
Priority: 1
Reference case:
Isolation Level: Repeatable Read
Author: Ray

Test Plan: 
Test concurrent DELETE/UPDATE transactions in MVCC (with single index schema)

Test Scenario:
C1 delete, C2 update, the affected rows are not overlapped (based on where clause)
C1, C2 where clause are all on index (i.e. index scan), index scans are not overlapped
C2 updates an index column (the updated value is not included in C1 index scan)
C1 commit, C2 commit
Metrics: schema = single table, index = single index, data size = small, where clause = simple

Test Point:
1) C1 and C2 will not be waiting (Locking Test)
2) C1 and C2 can only see the its own delete/update but not other transactions changes (Visibility Test) 
3) C1 instances should be deleted, C2 instances should be updated

NUM_CLIENTS = 3
C1: delete from table t1;
C2: update table t1;  
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
C1: CREATE TABLE t1(id INT, col VARCHAR(10));
C1: CREATE INDEX idx_id on t1(id);
C1: INSERT INTO t1 VALUES(1,'abc');INSERT INTO t1 VALUES(2,'def');INSERT INTO t1 VALUES(3,'ghi');INSERT INTO t1 VALUES(4,'jkl');INSERT INTO t1 VALUES(5,'mno');INSERT INTO t1 VALUES(1,'bcd');INSERT INTO t1 VALUES(6,'pqr');
C1: COMMIT WORK;
MC: wait until C1 ready;

/* test case */
C1: DELETE FROM t1 WHERE id = 5;
MC: wait until C1 ready;
C2: UPDATE t1 set id = 0 WHERE id = 6;
/* expect: no transactions need to wait */
MC: wait until C2 ready;
/* expect: C1 select - id = 5 is deleted */
C1: SELECT * FROM t1 ORDER BY 1,2;
C1: commit;
/* expect: C2 select - id = 6 is updated, but id = 5 is still existed */
C2: SELECT * FROM t1 ORDER BY 1,2;
C2: commit;
/* expect: the instances of id = 5 is deleted, id = 6 is updated */
C3: select * from t1 ORDER BY 1,2;
C3: commit;

C1: quit;
C2: quit;
C3: quit;