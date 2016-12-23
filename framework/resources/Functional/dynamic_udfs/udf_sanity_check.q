create function using jar 'udf_sanity_check-1.0.jar';
select get1(), get2(), get3() from (values(1));
drop function using jar 'udf_sanity_check-1.0.jar';
