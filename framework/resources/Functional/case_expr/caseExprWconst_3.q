SELECT * FROM (VALUES((coalesce(cast(null as integer),0) IS NOT NULL))) test_tbl;