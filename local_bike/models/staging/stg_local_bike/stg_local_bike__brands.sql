SELECT
    cast(brand_id as int64) as brand_id,
    trim(brand_name) AS brand_name,
FROM {{source('db_local_bike', 'brands')}}