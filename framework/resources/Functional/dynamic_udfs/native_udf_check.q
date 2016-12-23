create function using jar 'native_udf_check-1.0.jar';
select TO_TIMESTAMP('2008-2-23 12:00:00', 'yyyy-MM-dd HH:mm:ss'), from_utc_timestamp('2008-2-23 14:00:00',''), dateudf() from (values(1));
drop function using jar 'native_udf_check-1.0.jar';
