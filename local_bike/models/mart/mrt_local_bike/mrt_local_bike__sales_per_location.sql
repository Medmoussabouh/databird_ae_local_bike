
{{ config(
    cluster_by = ["store_state", "product_id"],
    partition_by = {
      "field": "order_date",
      "data_type": "date"
    }
) }}

SELECT
  order_date,
  store_state,
  product_id,
  sum(revenue) as total_revenue,
  count(DISTINCT(order_id)) as total_orders,
  round(safe_divide(sum(coalesce(revenue, 0)) , count(distinct(order_id))), 2) as aov
from {{ ref('int_local_bike__sales') }}
group by 
  order_date,
  store_state,
  product_id
