select 1 from(values(1));
select t1.inv_date_sk, t1.inv_item_sk, t1.inv_warehouse_sk, t1.inv_quantity_on_hand,  registerfromone(cast(t1.inv_date_sk as varchar), cast(t2.inv_item_sk as varchar)) from dfs.`drill/testdata/tpcds_sf1/json/inventory` t1 inner join (select inv_date_sk, inv_item_sk, registerfromone(cast(inv_date_sk as varchar), cast(inv_item_sk as varchar)) as tmp_res from dfs.`drill/testdata/tpcds_sf1/json/inventory`) t2 on registerfromone(cast(t1.inv_date_sk as varchar), cast(t1.inv_item_sk as varchar))=t2.tmp_res where t1.inv_date_sk=2450815 and t1.inv_item_sk=1 and t1.inv_warehouse_sk=3 and t1.inv_quantity_on_hand=494 limit 1;
drop function using jar 'register_from_one-1.0.jar';
