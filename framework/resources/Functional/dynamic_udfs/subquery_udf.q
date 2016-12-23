create function using jar 'subquery_udf-1.0.jar';
select subqueryudf(t1.first_name, t2.last_name) from cp.`employee.json` t1 inner join (select last_name, subqueryudf(first_name, last_name) as full_name from cp.`employee.json`) t2 on subqueryudf(t1.first_name, t1.last_name)=t2.full_name where t1.employee_id=1 limit 1;
drop function using jar 'subquery_udf-1.0.jar';
