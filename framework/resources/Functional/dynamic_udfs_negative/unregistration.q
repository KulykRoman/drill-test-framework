create function using jar 'unregistration-1.0.jar';
select unregistration() from (values(1));
drop function using jar 'unregistration-1.0.jar';
select unregistration() from (values(1));
select 1 from (values(1));
select 1 from (values(1));
select 1 from (values(1));
