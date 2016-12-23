create function using jar 'udf_with_packages-1.0.jar';
select simpleudf1() from (values(1));
select simpleudf3() from (values(1));
select simpleudf2() from (values(1));
select simpleudf3() from (values(1));
select simpleudf1() from (values(1));
drop function using jar 'udf_with_packages-1.0.jar';
