--+ holdcas on;
set names utf8;
set system parameters 'intl_date_lang = de_DE';
create table t( a DATE);
insert into t value(DATE '31.1.2012' );
drop table t;
set system parameters 'intl_date_lang = en_US';
set names iso88591;
commit;
--+ holdcas off;