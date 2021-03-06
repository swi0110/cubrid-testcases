--+ holdcas on;
set names utf8;
set system parameters 'intl_number_lang = ko_KR';
set system parameters 'intl_date_lang = ko_KR';
create table t( a DATE);
insert into t value(DATE '01/03/2012' );
insert into t value(DATE '1/31/2012' );
insert into t value(DATE '2012.01.31' );
insert into t value('2012.1.9' );
insert into t VALUES (DATE '11-11-1994' );
select * from t order by 1;
drop table t;
set system parameters 'intl_date_lang = en_US';
set system parameters 'intl_number_lang = en_US';
set names iso88591;
commit;
--+ holdcas off;