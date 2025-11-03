SELECT
  store_state, 
  product_category_name,
  ROUND(sum(coalesce(revenue, 0)), 2) as total_revenue
from {{ ref('int_local_bike__sales') }}
group by 
  store_state, product_category_name
