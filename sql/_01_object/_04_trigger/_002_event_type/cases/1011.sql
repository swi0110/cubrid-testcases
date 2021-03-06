--Create trigger with statement insert tigger event type
create class test_class(col1 integer, col2 varchar(20));

create class op_record(operator varchar(20), 
                       op_action varchar(50), 
                       op_time timestamp default '2008-05-27 15:50:58');
create trigger test_trigger
  before statement insert on test_class
  execute insert into op_record
          values(user, 'insert a record to test_class', '2008-05-27 15:50:58');
insert into test_class values(999,'nhn');
insert into test_class values(888,'nhn');
insert into test_class values(999,'nhn');
insert into test_class values(888,'nhn');
  

select * from op_record;


drop trigger test_trigger;
drop class test_class;
drop class op_record;
