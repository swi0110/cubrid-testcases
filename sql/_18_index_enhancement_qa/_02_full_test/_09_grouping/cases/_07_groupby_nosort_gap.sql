--+ holdcas on;
set system parameters 'dont_reuse_heap_file=yes';
create table x (a int, b int, c int, d int, e int, f int);
insert into x values (1,1,1,1,1,1);
insert into x values (10,10,10,10,10,10);
insert into x values (10,10,10,10,10,10);
insert into x values (10,11,10,11,10,11);
create index i_x_a_b_c_d_e_f on x (a,b,c,d,e,f);

select /*+ recompile */ b, count(*) from x where a=10 group by b,c,d,e,f;
select /*+ recompile */ d,e,f, count(*) from x where a=10 and b=10 and c=10 group by d,e,f;
select /*+ recompile */ f, count(*) from x where a=10 and b=10 and c=10 and d=10 and e=10 group by f;
select /*+ recompile */ b,c,d,e, count(*) from x where a=10 and f=10 group by b,c,d,e;
select /*+ recompile */ a,b,c,d,e,f, count(*) from x where a>0 group by a,b,c,d,e,f;


select /*+ recompile */ b,d,e,f, count(*) from x where a=10 and c=10 group by b,d,e,f;
select /*+ recompile */ b,d, count(*) from x where a=10 and c=10 group by b,d;
select /*+ recompile */ b,d,f, count(*) from x where a=10 and c=10 and e=10 group by b,d,f;

drop table x;

set system parameters 'dont_reuse_heap_file=no';
commit;
--+ holdcas off;
