-- create table and alter add attribute whose type is udt
set system parameters 'create_table_reuseoid=no';

CREATE TABLE StateCity(State CHAR(20), City CHAR(20));
CREATE TABLE Company  (Name CHAR(20), Location StateCity not null primary KEY, Budget FLOAT);

CREATE TABLE company1 (name CHAR(20),budget FLOAT);
ALTER TABLE company1 ADD ATTRIBUTE  Location StateCity;


DROP table company1;
drop CLASS Company;
drop CLASS StateCity;

set system parameters 'create_table_reuseoid=yes';
