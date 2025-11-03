SELECT
    cast(product_id as int64) as product_id,
    trim(product_name) AS product_name,
    cast(brand_id as int64) as product_brand_id,
    cast(category_id as int64) as product_category_id,
    cast(model_year as int64) as product_model_year,
    cast(list_price as float64) as product_list_price
FROM {{source('db_local_bike', 'products')}}