select updatefunction() from (values(1));
drop function using jar 'update_function-1.0.jar';
create function using jar 'update_function-1.0.jar';
select updatefunction() from (values(1));
drop function using jar 'update_function-1.0.jar';
select 1 from (values(1));
select 1 from (values(1));
