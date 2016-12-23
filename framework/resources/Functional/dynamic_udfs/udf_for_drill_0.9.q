create function using jar 'udf_for_drill_0.9-1.0.jar';
select oldudf() from (values(1));
drop function using jar 'udf_for_drill_0.9-1.0.jar';
