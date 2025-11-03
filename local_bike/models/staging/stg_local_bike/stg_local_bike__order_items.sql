SELECT
    CONCAT(order_id, '_', product_id) AS order_item_id,
    cast(order_id as int64) as order_item_order_id,
    cast(product_id as int64) as order_item_product_id,
    cast(coalesce(quantity, 0) as int64) as order_item_quantity,
    cast(coalesce(discount, 0) as float64) as order_item_discount_rate,
    cast(coalesce(list_price, 0) as float64) as order_item_list_price
FROM {{source('db_local_bike', 'order_items')}}
