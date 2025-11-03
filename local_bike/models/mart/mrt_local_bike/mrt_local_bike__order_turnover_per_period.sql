
SELECT
  order_date,
  sum(coalesce(revenue)) as total_revenue,
  count(DISTINCT(order_id)) as total_orders,
  round(safe_divide(sum(revenue), count(distinct(order_id))) , 2) as aov
from {{ ref('int_local_bike__sales') }}
group by 
  order_date
order by aov desc