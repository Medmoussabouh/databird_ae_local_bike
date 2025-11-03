SELECT
  store_state, 
  product_name,
  avg(coalesce(order_item_list_price, 0)) as order_item_list_price,
  sum(coalesce(order_item_quantity, 0)) as total_sold_quantity,
  ROUND(sum(coalesce(revenue, 0)), 2) as total_revenue,
from {{ ref('int_local_bike__sales') }}
group by 
  store_state, product_name

