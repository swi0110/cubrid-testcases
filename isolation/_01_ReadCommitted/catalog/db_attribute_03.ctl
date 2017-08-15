/*
Test Case: update & update db_attribute
Priority: 1
Reference case:
Author: Lily

Test Point:
- C1 update db_attribute  
- C2 update db_attribute 
- C3 select from db_attribute; 
*/

MC: setup NUM_CLIENTS = 3;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;
C3: set transaction lock timeout INFINITE;
C3: set transaction isolation level read committed;
C2: commit;
C3: commit;
/* preparation */
C1: DROP TABLE IF EXISTS tb1;
C1: DROP TABLE IF EXISTS tb2;
C1: CREATE TABLE tb1(id INT , grade INT,email VARCHAR(20));
C1: INSERT INTO tb1 VALUES(1,10,'mike@nnn.com');
C1: CREATE TABLE tb2(id INT , grade INT,email VARCHAR(20));
C1: INSERT INTO tb2 VALUES(1,10,'mike@nnn.com');
C1: commit;
MC: wait until C1 ready;

/* test case */
/* different table */
C1: alter table tb1 change grade col varchar(10);
MC: wait until C1 ready;
C2: alter table tb2 modify grade bigint not null;
MC: wait until C2 ready;
C3: select * from db_attribute where class_name like 'tb%' order by 1,2;
MC: wait until C3 ready;
C1: commit;
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
C3: select * from db_attribute where class_name like 'tb%' order by 1,2;
C3: commit;
MC: wait until C3 ready;

/* same table different column */
C2: ALTER TABLE tb1 change col grade int;
MC: wait until C2 ready;
C3: rename tb1 as tb1_rename;
MC: wait until C3 blocked;
C1: select * from db_attribute where class_name like 'tb%' order by 1,2;
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
C3: commit;
MC: wait until C3 ready;
C1: select * from db_attribute where class_name like 'tb%' order by 1,2;
C1: rename tb1_rename as tb1;
C1: commit;
MC: wait until C1 ready;

/* same table same column */
C2: ALTER TABLE tb1 modify email VARCHAR(100);
MC: wait until C2 ready;
C3: ALTER TABLE tb1 change email email VARCHAR(50);
MC: wait until C3 blocked;
C1: select * from db_attribute where class_name like 'tb%' order by 1,2;
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
C3: commit;
MC: wait until C3 ready;
C1: select * from db_attribute where class_name like 'tb%' order by 1,2;
C1: commit;
MC: wait until C1 ready;

C3: quit;
C2: quit;
C1: quit;
