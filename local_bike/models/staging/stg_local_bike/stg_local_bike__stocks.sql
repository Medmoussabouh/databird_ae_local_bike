SELECT
  CONCAT(store_id, '_', product_id) AS store_product_id,
  cast(store_id as int64) as store_id,
  cast(product_id as int64) as product_id,
  cast(quantity as int64) as available_quantity
FROM
{{ source('db_local_bike', 'stocks') }}