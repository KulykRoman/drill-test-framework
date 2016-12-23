select 1 from (values(1));
create function using jar 'exists_udf-1.0.jar';
drop function using jar 'exists_udf-1.0.jar';
