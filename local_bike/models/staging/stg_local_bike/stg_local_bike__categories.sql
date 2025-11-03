SELECT
    cast(category_id as int64) as category_id,
    trim(category_name) AS category_name,
FROM {{source('db_local_bike', 'categories')}}