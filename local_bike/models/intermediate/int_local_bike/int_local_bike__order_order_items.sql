SELECT 
    o.*,
    oi.*,
    ROUND((oi.order_item_quantity * oi.order_item_list_price * (1 - coalesce(oi.order_item_discount_rate,0))), 2) as revenue,
    p.*
FROM {{ ref('stg_local_bike__orders') }} AS o
INNER JOIN {{ ref('stg_local_bike__order_items') }} AS oi ON o.order_id = oi.order_item_order_id
INNER JOIN {{ ref('int_local_bike__products') }} AS p ON p.product_id = oi.order_item_product_id
 