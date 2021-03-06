set system parameters 'create_table_reuseoid=no';
-- This testcase use modified Oracle samples. See below for the license:
-- Copyright (c) 2015 Oracle
-- Permission is hereby granted, free of charge, to any person obtaining a copy
--  of this software and associated documentation files (the "Software"), to deal
--  in the Software without restriction, including without limitation the rights
--  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--  copies of the Software, and to permit persons to whom the Software is
--  furnished to do so, subject to the following conditions:
-- The above copyright notice and this permission notice shall be included in all
--  copies or substantial portions of the Software.
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--  SOFTWARE.

create class bonuses (emp_id int, bonus int);

insert into bonuses values (145,10);
insert into bonuses values (146,10);
insert into bonuses values (147,10);
insert into bonuses values (148,10);
insert into bonuses values (149,10);
insert into bonuses values (150,10);
insert into bonuses values (151,10);
insert into bonuses values (152,10);

insert into bonuses values (153,100);
insert into bonuses values (154,100);
insert into bonuses values (155,100);
insert into bonuses values (156,100);
insert into bonuses values (157,100);
insert into bonuses values (158,100);
insert into bonuses values (159,100);
insert into bonuses values (160,100);
insert into bonuses values (161,100);
insert into bonuses values (162,100);
insert into bonuses values (163,100);

insert into bonuses values (164,10);
insert into bonuses values (165,10);
insert into bonuses values (166,10);
insert into bonuses values (167,10);
insert into bonuses values (168,10);
insert into bonuses values (169,10);
insert into bonuses values (170,10);
insert into bonuses values (171,10);
insert into bonuses values (172,10);

create class emp (emp_id int, salary int);

insert into emp values (145,10);
insert into emp values (146,10);
insert into emp values (147,10);
insert into emp values (148,10);
insert into emp values (149,10);
insert into emp values (150,10);
insert into emp values (151,10);
insert into emp values (152,10);

insert into emp values (153,200);
insert into emp values (154,500);
insert into emp values (155,550);
insert into emp values (156,350);
insert into emp values (157,600);
insert into emp values (158,450);
insert into emp values (159,550);
insert into emp values (160,650);
insert into emp values (161,700);
insert into emp values (162,520);
insert into emp values (163,675);
insert into emp values (201,400);
insert into emp values (202,450);
insert into emp values (203,300);

insert into emp values (164,10);
insert into emp values (165,10);
insert into emp values (166,10);
insert into emp values (167,10);
insert into emp values (168,10);
insert into emp values (169,10);
insert into emp values (170,10);
insert into emp values (171,10);
insert into emp values (172,10);

create vclass v_bonuses as select * from bonuses where bonus != 10;
create vclass v_emp as select * from emp where emp_id between 153 and 163 or emp_id > 200;

merge into v_bonuses d using v_emp e on d.emp_id = e.emp_id when matched then update set d.bonus=d.bonus+e.salary*0.1 where e.salary<600 when not matched then insert (d.emp_id, d.bonus) values (e.emp_id, 100+e.salary*0.1) where e.salary<=400;

select * from v_bonuses order by 1;

drop bonuses;
drop emp;
drop v_bonuses;
drop v_emp;
set system parameters 'create_table_reuseoid=yes';
