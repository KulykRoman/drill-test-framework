create function using jar 'inner_udf-1.0.jar';
select concat(concatudf('t','e'),concatudf('s','t')), concatudf(concatudf('i','nn'),concatudf('e','r')), concatudf(concat('use','r '),concat('funct','ions')) from (values(1));
drop function using jar 'inner_udf-1.0.jar';
