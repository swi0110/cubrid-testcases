--TIME FUNCTION
SELECT TIME('2010-09-20 10:56:34');
SELECT TIME(TIME'10:56:34');
SELECT TIME(DATETIME'2010-09-20 10:56:34.1010');
SELECT TIME(TIMESTAMP'2010-09-20 10:56:34');

--YEAR FUNCTION
SELECT YEAR('2010-10-01');
SELECT YEAR('04/23/1999');
SELECT YEAR(DATE'2010-10-01');
SELECT YEAR(DATETIME'2010-10-01 22:39:56.1234');
SELECT YEAR(TIMESTAMP'2010-10-01 23:59:59');

--MONTH FUNCTION
SELECT MONTH('2010-10-01');
SELECT MONTH('04/23/1999');
SELECT MONTH(DATE'2010-10-01');
SELECT MONTH(DATETIME'2010-10-01 22:39:56.1234');
SELECT MONTH(TIMESTAMP'2010-10-01 23:59:59');

--DAY FUNCTION
SELECT DAY('2010-10-01');
SELECT DAY('04/23/1999');
SELECT DAY(DATE'2010-10-01');
SELECT DAY(DATETIME'2010-10-01 22:39:56.1234');
SELECT DAY(TIMESTAMP'2010-10-01 23:59:59');

--DAYOFMONTH FUNCTION
SELECT DAYOFMONTH('2010-10-01');
SELECT DAYOFMONTH('04/23/1999');
SELECT DAYOFMONTH(DATE'2010-10-01');
SELECT DAYOFMONTH(DATETIME'2010-10-01 22:39:56.1234');
SELECT DAYOFMONTH(TIMESTAMP'2010-10-01 23:59:59');






